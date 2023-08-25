#!/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-narrow.rasi"

SCREEN="  ◯   screen"
SELECTION="  ◯   selection"
SCREEN_CLIPBOARD_ONLY="  ◯   screen (clipboard only)"
SELECTION_CLIPBOARD_ONLY="  ◯   selection (clipboard only)"

cmd=$({ 
	echo "$SCREEN"; 
	echo "$SELECTION"; 
	echo "$SCREEN_CLIPBOARD_ONLY"; 
	echo "$SELECTION_CLIPBOARD_ONLY"; 
} | rofi -dmenu -l 4 -theme $theme -p "screenshot:")

mkdir "$HOME/Screenshots" 2> /dev/null

FILE_PATH="$HOME/Screenshots/sc-$(date +"%Y-%m-%dT%H:%M:%S%:z").png"

if [[ "$cmd" == "$SCREEN" ]]; then maim | tee $FILE_PATH | xclip -selection clipboard -t image/png
elif [[ "$cmd" == "$SELECTION" ]]; then maim -s | tee $FILE_PATH | xclip -selection clipboard -t image/png
elif [[ "$cmd" == "$SCREEN_CLIPBOARD_ONLY" ]]; then maim | xclip -selection clipboard -t image/png
elif [[ "$cmd" == "$SELECTION_CLIPBOARD_ONLY" ]]; then maim -s | xclip -selection clipboard -t image/png
fi