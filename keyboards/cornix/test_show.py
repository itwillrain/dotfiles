import json
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parent


class ShowTest(unittest.TestCase):
    def show(self, *args):
        return subprocess.run(
            [sys.executable, str(ROOT / "show.py"), *args],
            capture_output=True,
            text=True,
            check=False,
        )

    def test_default_shows_all_active_layers_in_physical_order(self):
        result = self.show()
        self.assertEqual(result.returncode, 0, result.stderr)
        rows = [" ".join(line.split()) for line in result.stdout.splitlines()]
        self.assertIn("Esc Q W E R T | Y U I O P Bksp", rows)
        self.assertIn("Ctrl A S D F G | H J K L ; '", rows)
        self.assertIn("Tab Ctrl Opt Cmd Space Tab/Num | BS/Nav Enter Cmd Opt Ctrl Tab", rows)
        self.assertIn("BS/Nav = タップでBackspace / 長押しでNav", result.stdout)
        self.assertIn("Tab/Num = タップでTab / 長押しでNum", result.stdout)
        for title in ("[0] 通常", "[1] 数字・記号", "[2] 移動・Fキー", "[3] 接続"):
            self.assertIn(title, result.stdout)

    def test_symbols_show_us_symbols_and_inherited_thumb_keys(self):
        result = self.show("1")
        self.assertEqual(result.returncode, 0, result.stderr)
        rows = [" ".join(line.split()) for line in result.stdout.splitlines()]
        self.assertIn("Esc 1 2 3 4 5 | 6 7 8 9 0 Del", rows)
        self.assertIn("Ctrl ! @ # $ % | ^ & * ( ) \\", rows)
        self.assertIn("Shift ` - = [ ] | { } < > / Shift", rows)
        self.assertIn("Tab Ctrl Opt Cmd Space Tab/Num | BS/Nav Enter Cmd Opt Ctrl Tab", rows)
        self.assertNotIn("[0] 通常", result.stdout)

    def test_navigation_matches_vim_positions(self):
        result = self.show("2")
        self.assertEqual(result.returncode, 0, result.stderr)
        rows = [" ".join(line.split()) for line in result.stdout.splitlines()]
        self.assertIn("Ctrl Opt F6 F7 F8 F9 | Left Down Up Right ; '", rows)

    def test_invalid_layer_reports_error(self):
        result = self.show("10")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("invalid choice", result.stderr)

    def test_vial_identity_preserves_official_64_bit_uid(self):
        data = json.loads((ROOT / "keymap.vil").read_text())
        self.assertEqual(data["uid"], 16882930253541522617)

    def test_connection_layer_keeps_navigation_keys_and_bt_channels(self):
        result = self.show("3")
        self.assertEqual(result.returncode, 0, result.stderr)
        rows = [" ".join(line.split()) for line in result.stdout.splitlines()]
        self.assertIn("Sys BT0 BT1 BT2 Out F5 | Del Home PgUp End PgDn Bksp", rows)
        self.assertIn("Ctrl Opt F6 F7 F8 F9 | Left Down Up Right ; '", rows)


if __name__ == "__main__":
    unittest.main()
