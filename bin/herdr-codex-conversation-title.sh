#!/bin/sh
# Report the current Codex conversation title to Herdr's agent sidebar.
# The title is read from Codex's local session index by session id.

set -eu

[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_SOCKET_PATH:-}" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0
command -v python3 >/dev/null 2>&1 || exit 0

hook_json=$(cat)

python3 - "$HOME/.codex/session_index.jsonl" "$hook_json" <<'PY'
import json
import os
import socket
import sys
import time
import uuid

try:
    hook = json.loads(sys.argv[2])
except Exception:
    raise SystemExit(0)

session_id = hook.get("session_id")
if not isinstance(session_id, str) or not session_id:
    raise SystemExit(0)

index_path = sys.argv[1]
title = None
try:
    with open(index_path, encoding="utf-8") as handle:
        for line in handle:
            try:
                entry = json.loads(line)
            except Exception:
                continue
            if entry.get("id") == session_id and isinstance(entry.get("thread_name"), str):
                title = entry["thread_name"].strip() or None
except OSError:
    raise SystemExit(0)

if not title:
    raise SystemExit(0)

request = {
    "id": f"user:codex-title:{uuid.uuid4()}",
    "method": "pane.report_metadata",
    "params": {
        "pane_id": os.environ["HERDR_PANE_ID"],
        "source": "user:codex-thread-title",
        "agent": "codex",
        "seq": time.time_ns(),
        "ttl_ms": 86400000,
        "state_labels": {
            "idle": "IDLE",
            "working": "WORKING",
            "blocked": "BLOCKED",
            "done": "DONE",
            "unknown": "UNKNOWN",
        },
        "tokens": {"conversation": title[:80]},
    },
}

try:
    client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    client.settimeout(0.5)
    client.connect(os.environ["HERDR_SOCKET_PATH"])
    client.sendall((json.dumps(request) + "\n").encode())
    try:
        client.recv(4096)
    except Exception:
        pass
    client.close()
except Exception:
    pass
PY
