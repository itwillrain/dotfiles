# Cornix

HHKB USから移行するmacOS向けキーマップ。`keymap.vil`を正として編集し、
Vialからキーボードへ読み込む。ターミナル一覧も同じファイルから表示する。

## すぐ確認する

Fishでは、作業中のディレクトリに関係なく表示できる。

```shell
cornix          # 全レイヤー
cornix 1        # 数字・記号だけ
cornix 2        # 移動・Fキーだけ
```

ほかのシェルでは、リポジトリでmiseを使う。

```shell
mise run cornix:show
mise run cornix:show -- 1
mise run cornix:check
```

## キーボードへ反映する

1. 左右の電源を入れ、左側をUSBでMacに接続する。
2. VialアプリでCornixを選択する。
3. `File → Save current layout`で現在の設定をリポジトリ外へ保存する。
4. `File → Load saved layout`で、このディレクトリの`keymap.vil`を選ぶ。
5. 文字、数字・記号、親指のレイヤー切り替え、矢印を実際に入力して確認する。

ファイルを読み込むと接続中のキーボードに設定が書き込まれる。
`mise bootstrap`やGit上のファイル編集だけでは本体へ反映されない。
Vialで変更した配列を残す場合は、`Save current layout`で`keymap.vil`へ保存し直す。
マクロ、コンボなども読み込み対象なので、取り込み前に現在の設定を保存する。

対象は公式Vialファームウェア。ZMKへ変更した個体にはこのファイルを使わない。
Vialが別のキーボードとして認識する場合は、実機からエクスポートしたファイルと
`uid`や配列の行列サイズを比較する。警告を無視して読み込まない。

## 配列

通常レイヤーはQWERTY、Aの左がCtrl、右上がBackspace。
Escは通常レイヤーと数字・記号レイヤーでEscになる。
左右の下段は、外側3キーと親指3キーを左から右へ並べて表示する。
親指3キーは左がCommand・Space・Tab/Num、右がBS/Nav・Enter・Command。
Tab/NumはタップでTab、長押しで数字レイヤーのNumになる。
BS/NavはタップでBackspace、長押しで移動レイヤーのNavになる。
Backspaceは右親指のBS/Navのタップと右上のキーで使える。
下段の外側3キーは左がTab・Ctrl・Option、右がCommand・Option・Ctrl。
左のCommandを内側へ寄せ、Tabは左右の一番外側にも置いた。右はBS/Nav・Enter・Command・Option・Ctrl・Tabの順にした。
CommandをOptionより親指寄りに置き、AeroSpaceのOptionショートカットと
Command＋数字を押せるようにする。

| レイヤー | 押し方 | 用途 |
| --- | --- | --- |
| 0 | 通常 | 文字、Space、Enter、Tab、修飾キー |
| 1 | 左親指のTab/Numを長押ししている間 | 数字、記号、括弧 |
| 2 | 右親指のBS/Navを長押ししている間 | H/J/K/L位置の矢印、F1〜F12、英数・かな |
| 3 | BS/Navを長押ししながらEsc位置のSysを押している間 | Q/W/E位置のBT0/BT1/BT2、R位置の接続優先切り替え |

左ノブは音量、押下はミュート。右ノブはスクロール、押下はマウス中ボタン。
US入力ソースを想定し、`Shift + -`で`_`、`Shift + =`で`+`、
`Shift + \`で`|`を入力する。

一覧は選択レイヤーの透過キーを解決した表示。接続レイヤーは0・2・3が
有効な状態で表示する。本体から状態を読み取る機能はないため、
本体とファイルが一致するのはVialから読み込んだ後になる。

## ファイルの編集

`.vil`はJSON。各レイヤーは8行×7列で、行の順序は次のとおり。

| 行 | キーの並び |
| --- | --- |
| 0〜2 | 左側の上・中・下段。列0〜5を左から右へ読む |
| 3 | 左側の最下段。外側3キー、親指3キーの順 |
| 4〜6 | 右側の上・中・下段。列5〜0を左から右へ読む |
| 7 | 右側の最下段。列5〜0を左から右へ読む |

左ノブ押下は行2・列6、右ノブ押下は行5・列6。
`-1`はキーのない位置。`KC_TRNS`は透過、`KC_NO`は無効。
`MO(1)`などは押している間だけレイヤーを有効にするキー。
`LT1(KC_TAB)`はタップでTab、長押しでレイヤー1を有効にするキー。
`LT2(KC_BSPACE)`はタップでBackspace、長押しでレイヤー2を有効にするキー。
右側の行は逆順なので、変更後は`cornix`で物理的な並びを確認する。
64ビットの`uid`は整数の精度を失わないエディタやツールで扱う。

## 出典と検証

2026-10-10に取得した[公式日本語マニュアル](https://docs.channel.io/jezailfunderjp/ja/articles/Cornix-日本語マニュアル-c1160246)の
`cornix-default-keymap.vil`を土台にしている。10レイヤーとノブ設定を維持し、
レイヤー0〜3のキー割り当てを変更した。
行列と独自キーコードの位置は[公式V1.12ファームウェア](https://github.com/jezailfunder/cornix-lp/tree/main/cornix%E5%9B%BA%E4%BB%B6%20V1.12)の
配列定義で確認した。

[Vialの読み込み処理](https://github.com/vial-kb/vial-gui/blob/main/src/main/python/protocol/keyboard_comm.py)に合わせたJSON形式。
テストはターミナルの表示順、記号、透過キー、レイヤー選択、識別子を確認する。
キーボードへの読み込みと実際の打鍵は、まだ検証していない。

[親指キー配置の参考記事](https://note.com/sugitlab/n/n7a12486a1a75)を確認し、
左親指のBackspaceをSpaceへ変更し、右親指にタップでBackspace・長押しでNavを割り当てた。
左親指のNumはタップでTab・長押しで数字レイヤーに切り替える。
レイヤータップの保存形式は[Vialのキーコード定義](https://github.com/vial-kb/vial-gui/blob/master/src/main/python/keycodes/keycodes.py)で確認した。
