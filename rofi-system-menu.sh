#!/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-narrow.rasi"

POWEROFF="  ◯   poweroff"
REBOOT="  ◯   reboot"
LOGOUT="  ◯   logout"

cmd=$({ 
	echo "$POWEROFF"; 
	echo "$REBOOT"; 
	echo "$LOGOUT"; 
} | rofi -dmenu -l 3 -theme $theme -w 100px -p "  ")

if [[ "$cmd" == "$POWEROFF" ]]; then poweroff & sleep 90
elif [[ "$cmd" == "$REBOOT" ]]; then reboot & sleep 90
elif [[ "$cmd" == "$LOGOUT" ]]; then i3-msg exit & sleep 90
fi