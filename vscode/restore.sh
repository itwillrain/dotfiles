#!/bin/sh

CMDNAME=`basename $0`

while getopts :s OPT
do
  case $OPT in
    "s" ) FLG_S="TRUE" ;;
      * ) echo "Usage: $CMDNAME [-s]" 1>&2
          exit 1 ;;
  esac
done

shift `expr $OPTIND - 1`

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

if [ -e "$VSCODE_SETTING_DIR/settings.json" ]; then
  rm "$VSCODE_SETTING_DIR/settings.json"
  ln -s "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
fi

if [ -e "$VSCODE_SETTING_DIR/keybindings.json" ]; then
  rm "$VSCODE_SETTING_DIR/keybindings.json"
  ln -s "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"
fi

if [ "$FLG_S" != "TRUE" ]; then
  cat ./extensions | while read line
  do
    code --install-extension $line
  done
  code --list-extensions > extensions
fi


