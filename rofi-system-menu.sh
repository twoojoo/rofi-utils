#!/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-power-menu.rasi"
theme_confirm="${script_dir}theme-power-menu-confirm.rasi"

POWEROFF="poweroff  ◯"
REBOOT="reboot  ◯"
LOGOUT="logout  ◯"

choice=$({ 
	echo "$POWEROFF"; 
	echo "$REBOOT"; 
	echo "$LOGOUT"; 
} | rofi -dmenu -l 3 -theme $theme)

prompt=""

if [[ "$choice" == "$POWEROFF" ]]; then prompt="poweroff?"
elif [[ "$choice" == "$REBOOT" ]]; then prompt="reboot?"
elif [[ "$choice" == "$LOGOUT" ]]; then prompt="logout?"
else exit
fi

confirm=$({ 
	echo "yes  ◯"; 
	echo "no  ◯";
} | rofi -dmenu -l 2 -theme $theme_confirm -p $prompt)

if [[ "$confirm" == "yes  ◯" ]]; then
	echo $choice;
	if [[ "$choice" == "$POWEROFF" ]]; then poweroff & sleep 90
	elif [[ "$choice" == "$REBOOT" ]]; then reboot & sleep 90
	elif [[ "$choice" == "$LOGOUT" ]]; then i3-msg exit & sleep 90
	else exit
	fi;
fi