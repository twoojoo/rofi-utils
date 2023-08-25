#!/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-narrowest.rasi"

YES="  ◯   yes"
NO="  ◯   no"

cmd=$({ 
	echo "$YES"; 
	echo "$NO"; 
} | rofi -dmenu -l 2 -theme $theme -p "confirm?")

if [[ "$cmd" == "$YES" ]]; then echo "yes"
elif [[ "$cmd" == "$NO" ]]; then echo "no"
fi