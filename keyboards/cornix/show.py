import argparse
import json
from pathlib import Path


KEYMAP = Path(__file__).with_name("keymap.vil")
TITLES = ("通常", "数字・記号", "移動・Fキー", "接続")
LABELS = {
    "KC_ESCAPE": "Esc", "KC_BSPACE": "Bksp", "KC_DELETE": "Del",
    "KC_LCTRL": "Ctrl", "KC_RCTRL": "Ctrl",
    "KC_LSHIFT": "Shift", "KC_RSHIFT": "Shift",
    "KC_LGUI": "Cmd", "KC_RGUI": "Cmd",
    "KC_LALT": "Opt", "KC_RALT": "Opt",
    "KC_TAB": "Tab", "KC_SPACE": "Space", "KC_ENTER": "Enter",
    "KC_SCOLON": ";", "KC_QUOTE": "'", "KC_GRAVE": "`",
    "KC_COMMA": ",", "KC_DOT": ".", "KC_SLASH": "/", "KC_BSLASH": "\\",
    "KC_MINUS": "-", "KC_EQUAL": "=", "KC_LBRACKET": "[", "KC_RBRACKET": "]",
    "KC_EXLM": "!", "KC_AT": "@", "KC_HASH": "#", "KC_DLR": "$",
    "KC_PERC": "%", "KC_CIRC": "^", "KC_AMPR": "&", "KC_ASTR": "*",
    "KC_LPRN": "(", "KC_RPRN": ")", "KC_LCBR": "{", "KC_RCBR": "}",
    "KC_LT": "<", "KC_GT": ">",
    "KC_LEFT": "Left", "KC_DOWN": "Down", "KC_UP": "Up", "KC_RIGHT": "Right",
    "KC_HOME": "Home", "KC_END": "End", "KC_PGUP": "PgUp", "KC_PGDOWN": "PgDn",
    "KC_LANG2": "Eisu", "KC_LANG1": "Kana",
    "KC_MUTE": "Mute", "KC_BTN3": "Mouse3", "KC_NO": "-",
    "MO(1)": "Num", "MO(2)": "Nav", "MO(3)": "Sys",
    "LT1(KC_TAB)": "Tab/Num", "LT2(KC_BSPACE)": "BS/Nav",
    "USER00": "BT0", "USER01": "BT1", "USER02": "BT2", "USER06": "Out",
}


def label(code):
    return LABELS.get(code, code.removeprefix("KC_"))


def render_layer(layout, index):
    active = (0, 2, 3) if index == 3 else (0, index)

    def key(row, col):
        for layer in reversed(active):
            code = layout[layer][row][col]
            if code != "KC_TRNS":
                return label(code)
        return "-"

    def row(left, right):
        return " ".join(f"{item:<7}" for item in left) + "  |  " + " ".join(
            f"{item:<7}" for item in right
        ).rstrip()

    lines = [f"[{index}] {TITLES[index]}"]
    for number in range(3):
        lines.append(row(
            [key(number, col) for col in range(6)],
            [key(number + 4, col) for col in reversed(range(6))],
        ))
    lines.append("")
    lines.append(row(
        [key(3, col) for col in range(6)],
        [key(7, col) for col in reversed(range(6))],
    ))
    lines.append(f"ノブ押下: 左 {key(2, 6)} / 右 {key(5, 6)}")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="Cornixのキーマップを手元から見た順で表示")
    parser.add_argument("layer", nargs="?", type=int, choices=range(4))
    args = parser.parse_args()
    data = json.loads(KEYMAP.read_text())
    indices = range(4) if args.layer is None else (args.layer,)
    print("Cornix / HHKB US / macOS")
    print("下段は外側3キー＋親指3キー。表示は透過キーを解決済み。")
    print("Tab/Numを長押し = 1 / BS/Navを長押し = 2 / BS/Nav長押し + Esc位置のSys = 3\n")
    print("\n\n".join(render_layer(data["layout"], index) for index in indices))
    print("\nEisu = 英数 / Kana = かな / Opt = Option / Cmd = Command")
    print("BS/Nav = タップでBackspace / 長押しでNav")
    print("Tab/Num = タップでTab / 長押しでNum")
    print("Out = USB / Bluetoothの接続優先切り替え")
    print("US記号: Shift + - = _ / Shift + = = + / Shift + \\ = |")
    print("ファイルを編集した後は、Vialから再読み込みしてください。")


if __name__ == "__main__":
    main()
