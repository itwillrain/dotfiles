#!/usr/bin/env python3
"""Live Codex usage and process statistics for a Herdr pane."""

from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import time
from collections import deque
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ANSI_CLEAR = "\033[2J\033[H"
ANSI_DIM = "\033[2m"
ANSI_RESET = "\033[0m"
ANSI_CYAN = "\033[36m"
ANSI_GREEN = "\033[32m"
ANSI_YELLOW = "\033[33m"
ANSI_RED = "\033[31m"


@dataclass
class Usage:
    input_tokens: int = 0
    output_tokens: int = 0
    total_tokens: int = 0
    context_tokens: int = 0
    context_window: int = 0
    model: str = ""
    updated_at: str = ""


def codex_home() -> Path:
    configured = os.environ.get("CODEX_HOME")
    return Path(configured).expanduser() if configured else Path.home() / ".codex"


def compact_number(value: int) -> str:
    if value >= 1_000_000:
        return f"{value / 1_000_000:.1f}M"
    if value >= 1_000:
        return f"{value / 1_000:.1f}k"
    return str(value)


def percent(value: int, maximum: int) -> str:
    if not maximum:
        return "—"
    return f"{value / maximum * 100:.0f}%"


def memory(value_kb: int) -> str:
    if value_kb <= 0:
        return "—"
    if value_kb >= 1024 * 1024:
        return f"{value_kb / (1024 * 1024):.1f}G"
    return f"{max(1, value_kb // 1024)}M"


def load_titles(home: Path) -> dict[str, str]:
    titles: dict[str, str] = {}
    index_path = home / "session_index.jsonl"
    try:
        with index_path.open(encoding="utf-8") as handle:
            for line in handle:
                try:
                    item = json.loads(line)
                except json.JSONDecodeError:
                    continue
                session_id = item.get("id")
                title = item.get("thread_name")
                if isinstance(session_id, str) and isinstance(title, str) and title.strip():
                    titles[session_id] = title.strip()
    except OSError:
        pass
    return titles


def session_path(home: Path, session_id: str) -> Path | None:
    root = home / "sessions"
    if not root.is_dir():
        return None
    matches = list(root.glob(f"**/*-{session_id}.jsonl"))
    if not matches:
        return None
    return max(matches, key=lambda item: item.stat().st_mtime)


def read_usage(path: Path) -> Usage:
    usage = Usage()
    try:
        with path.open(encoding="utf-8", errors="replace") as handle:
            lines = deque(handle, maxlen=1600)
    except OSError:
        return usage

    for line in lines:
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        payload = event.get("payload") or {}
        if event.get("type") == "turn_context":
            model = payload.get("model")
            if isinstance(model, str) and model.strip():
                usage.model = model.strip()
        elif event.get("type") == "token_usage_record":
            totals = payload.get("thread_token_usage") or payload.get("usage") or {}
            usage.input_tokens = int(totals.get("input_tokens") or usage.input_tokens)
            usage.output_tokens = int(totals.get("output_tokens") or usage.output_tokens)
            usage.total_tokens = int(totals.get("total_tokens") or usage.total_tokens)
            response_usage = payload.get("usage") or {}
            usage.context_tokens = int(response_usage.get("input_tokens") or usage.context_tokens)
        elif event.get("type") == "event_msg" and payload.get("type") == "token_count":
            info = payload.get("info") or {}
            totals = info.get("total_token_usage") or {}
            latest = info.get("last_token_usage") or {}
            usage.input_tokens = int(totals.get("input_tokens") or usage.input_tokens)
            usage.output_tokens = int(totals.get("output_tokens") or usage.output_tokens)
            usage.total_tokens = int(totals.get("total_tokens") or usage.total_tokens)
            usage.context_tokens = int(latest.get("input_tokens") or usage.context_tokens)
            usage.context_window = int(info.get("model_context_window") or usage.context_window)
            usage.updated_at = str(event.get("timestamp") or usage.updated_at)
    return usage


def month_start_utc() -> datetime:
    local_now = datetime.now().astimezone()
    local_start = local_now.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
    return local_start.astimezone(timezone.utc)


def read_month_usage(home: Path) -> Usage:
    """Sum per-response token records written during the current local month."""
    totals = Usage()
    start = month_start_utc()
    root = home / "sessions"
    if not root.is_dir():
        return totals
    for path in root.glob("**/*.jsonl"):
        try:
            if path.stat().st_mtime < start.timestamp():
                continue
            with path.open(encoding="utf-8", errors="replace") as handle:
                for line in handle:
                    try:
                        event = json.loads(line)
                    except json.JSONDecodeError:
                        continue
                    if event.get("type") != "token_usage_record":
                        continue
                    timestamp = event.get("timestamp")
                    if not isinstance(timestamp, str):
                        continue
                    try:
                        event_time = datetime.fromisoformat(timestamp.replace("Z", "+00:00"))
                    except ValueError:
                        continue
                    if event_time < start:
                        continue
                    usage = (event.get("payload") or {}).get("usage") or {}
                    totals.input_tokens += int(usage.get("input_tokens") or 0)
                    totals.output_tokens += int(usage.get("output_tokens") or 0)
                    totals.total_tokens += int(usage.get("total_tokens") or 0)
        except OSError:
            continue
    return totals


def run_json(command: list[str], timeout: float = 1.5) -> dict[str, Any] | None:
    try:
        result = subprocess.run(command, capture_output=True, text=True, timeout=timeout)
        if result.returncode:
            return None
        return json.loads(result.stdout)
    except (OSError, subprocess.SubprocessError, json.JSONDecodeError):
        return None


def herdr_panes() -> list[dict[str, Any]]:
    workspaces = run_json(["herdr", "workspace", "list"])
    if not workspaces:
        return []
    panes: list[dict[str, Any]] = []
    for workspace in workspaces.get("result", {}).get("workspaces", []):
        workspace_id = workspace.get("workspace_id")
        if not isinstance(workspace_id, str):
            continue
        result = run_json(["herdr", "pane", "list", "--workspace", workspace_id])
        if result:
            panes.extend(result.get("result", {}).get("panes", []))
    return [pane for pane in panes if pane.get("agent") == "codex"]


def process_roots(panes: list[dict[str, Any]]) -> dict[str, int]:
    roots: dict[str, int] = {}
    for pane in panes:
        pane_id = pane.get("pane_id")
        if not isinstance(pane_id, str):
            continue
        result = run_json(["herdr", "pane", "process-info", "--pane", pane_id])
        processes = (result or {}).get("result", {}).get("process_info", {}).get("foreground_processes", [])
        for process in processes:
            if process.get("name") == "codex" and isinstance(process.get("pid"), int):
                roots[pane_id] = process["pid"]
                break
    return roots


def ps_snapshot() -> dict[int, tuple[int, float, int]]:
    try:
        result = subprocess.run(
            ["ps", "-axo", "pid=,ppid=,%cpu=,rss="],
            capture_output=True,
            text=True,
            timeout=1.5,
        )
    except (OSError, subprocess.SubprocessError):
        return {}
    if result.returncode:
        return {}
    processes: dict[int, tuple[int, float, int]] = {}
    for line in result.stdout.splitlines():
        fields = line.split()
        if len(fields) != 4:
            continue
        try:
            pid, ppid = int(fields[0]), int(fields[1])
            cpu, rss = float(fields[2]), int(fields[3])
        except ValueError:
            continue
        processes[pid] = (ppid, cpu, rss)
    return processes


def process_stats(root_pid: int, processes: dict[int, tuple[int, float, int]]) -> tuple[float, int]:
    if root_pid not in processes:
        return 0.0, 0
    children: dict[int, list[int]] = {}
    for pid, (ppid, _cpu, _rss) in processes.items():
        children.setdefault(ppid, []).append(pid)
    pending = [root_pid]
    seen: set[int] = set()
    cpu = 0.0
    rss = 0
    while pending:
        pid = pending.pop()
        if pid in seen:
            continue
        seen.add(pid)
        _ppid, pid_cpu, pid_rss = processes.get(pid, (0, 0.0, 0))
        cpu += pid_cpu
        rss += pid_rss
        pending.extend(children.get(pid, []))
    return cpu, rss


def state_color(state: str) -> str:
    if state == "working":
        return ANSI_YELLOW
    if state == "blocked":
        return ANSI_RED
    if state in {"idle", "done"}:
        return ANSI_GREEN
    return ANSI_DIM


def state_icon(state: str) -> str:
    return {
        "working": "●",
        "idle": "○",
        "done": "✓",
        "blocked": "!",
    }.get(state, "?")


def paint(value: str, color: str) -> str:
    return f"{color}{value}{ANSI_RESET}" if sys.stdout.isatty() else value


def context_bar(context_tokens: int, context_window: int, width: int) -> str:
    if not context_window:
        return "[—]"
    ratio = min(1.0, max(0.0, context_tokens / context_window))
    filled = round(ratio * width)
    return f"[{'█' * filled}{'░' * (width - filled)}]"


def render(home: Path, show_titles: bool = False) -> str:
    panes = herdr_panes()
    titles = load_titles(home)
    month_usage = read_month_usage(home)
    roots = process_roots(panes)
    processes = ps_snapshot()
    rows: list[str] = []
    total_cpu = 0.0
    total_rss = 0
    total_input = 0
    total_output = 0
    terminal_width = shutil.get_terminal_size((96, 24)).columns
    bar_width = max(8, min(16, terminal_width - 56))
    tabs: set[str] = set()

    for pane in sorted(panes, key=lambda item: (item.get("agent_status") != "working", item.get("pane_id", ""))):
        pane_id = str(pane.get("pane_id", "?"))
        session = pane.get("agent_session") or {}
        session_id = session.get("value") if isinstance(session, dict) else None
        usage = Usage()
        if isinstance(session_id, str):
            path = session_path(home, session_id)
            if path:
                usage = read_usage(path)
        title = pane.get("tokens", {}).get("conversation") or titles.get(session_id, "untitled")
        cpu, rss = process_stats(roots.get(pane_id, 0), processes)
        total_cpu += cpu
        total_rss += rss
        total_input += usage.input_tokens
        total_output += usage.output_tokens
        state = str(pane.get("agent_status") or "unknown")
        title = " ".join(str(title).split())
        model = usage.model or "model unknown"
        model = model[:18]
        icon = state_icon(state)
        tab_id = str(pane.get("tab_id", "?"))
        location = f"{pane.get('workspace_id', '?')}:{tab_id.split(':')[-1]}/{pane_id.split(':')[-1]}"
        tabs.add(tab_id)
        state_text = f"{icon} {state.upper()}"
        rows.append(f"{paint(state_text.ljust(14), state_color(state))} {paint(location.ljust(10), ANSI_DIM)} {model}")
        rows.append(
            f"  CTX {context_bar(usage.context_tokens, usage.context_window, bar_width)} "
            f"{percent(usage.context_tokens, usage.context_window):>4}  "
            f"Read {compact_number(usage.input_tokens):>7}  Write {compact_number(usage.output_tokens):>7}"
        )
        rows.append(f"  CPU {cpu:4.1f}%  Mem {memory(rss):>5}  Total {compact_number(usage.total_tokens):>7}")
        if show_titles:
            title_width = max(18, terminal_width - 6)
            if len(title) > title_width:
                title = title[: max(0, title_width - 1)] + "…"
            rows.append(f"  ↳ {title}")
        rows.append("")

    now = time.strftime("%H:%M:%S")
    lines = [
        paint(f"CODEX STATS  {now}  ·  {len(panes)} agents  ·  {len(tabs)} tabs", ANSI_CYAN),
        paint("─" * min(terminal_width, 72), ANSI_DIM),
        "",
    ]
    lines.extend(rows or [f"{ANSI_DIM}No active Codex panes detected.{ANSI_RESET}"])
    if rows:
        lines.extend(
            [
                paint(
                    f"TOTAL  CPU {total_cpu:.1f}%  ·  Mem {memory(total_rss)}  ·  "
                    f"Read {compact_number(total_input)}  ·  Write {compact_number(total_output)}",
                    ANSI_GREEN,
                ),
                "",
            ]
        )
    lines.extend(
        [
            paint(
                f"MONTH  Read {compact_number(month_usage.input_tokens)}  ·  "
                f"Write {compact_number(month_usage.output_tokens)}  ·  "
                f"Total {compact_number(month_usage.total_tokens)}",
                ANSI_CYAN,
            ),
            "",
        ]
    )
    lines.append(paint("CTX=latest request  ·  Read/Write=cumulative  ·  Ctrl-C to close", ANSI_DIM))
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--once", action="store_true", help="render once and exit")
    parser.add_argument("--interval", type=float, default=2.0, help="refresh interval in seconds")
    parser.add_argument("--show-titles", action="store_true", help="include conversation titles")
    args = parser.parse_args()
    home = codex_home()
    try:
        while True:
            output = render(home, args.show_titles)
            if sys.stdout.isatty():
                print(ANSI_CLEAR, end="")
            print(output, flush=True)
            if args.once:
                return 0
            time.sleep(max(0.5, args.interval))
    except KeyboardInterrupt:
        return 0


if __name__ == "__main__":
    raise SystemExit(main())
