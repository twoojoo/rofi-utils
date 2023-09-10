#!/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-medium.rasi"

options=(
	"  ◯   SCREEN [ file ]"
	"  ◯   SCREEN [ clipboard ]"
	"  ◯   SCREEN [ clipboard + file ]"
	"  ◯   SCREEN [ clipboard + edit ]"
	"  ◯   SCREEN [ clipboard + file + edit ]"
	"  ◯   SELECTION [ file ]"
	"  ◯   SELECTION [ clipboard ]"
	"  ◯   SELECTION [ clipboard + file ]"
	"  ◯   SELECTION [ clipboard + edit ]"
	"  ◯   SELECTION [ clipboard + file + edit ]"
)

selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 5 -theme $theme -p "screenshot:")
if [[ "$selected" == "" ]]; then exit; fi

img=""
file_path="$HOME/Screenshots/sc-$(date +"%Y-%m-%dT%H:%M:%S%:z").png"

if [[ "$selected" == *"SCREEN"* ]]; 
	then img=$(maim 2> /dev/null | tee $file_path); 
	else img=$(maim -s 2> /dev/null | tee $file_path); 
fi

if [[ "$img" == "" ]]; 
	then exit; 
fi

if [[ "$selected" == *"edit"* ]]; then 
	echo "editing: $file_path"
	img=$(pinta $file_path 2> /dev/null)
	echo $img
fi

if [[ "$selected" == *"clipboard"* ]]; then 
	echo "to clipboard: $file_path"
	cat $file_path | xclip -selection clipboard -t image/png
fi

if [[ "$selected" != *"file"*  ]]; 
	echo "removing: $file_path"
	then rm $file_path; 
fi