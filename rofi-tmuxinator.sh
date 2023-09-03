#1/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-medium.rasi"

function print_error {
	rofi -e "Error: $1" 
}

tmuxinator_folder="$HOME/.tmuxinator"

lines=$(ls $tmuxinator_folder | wc -l)
if [[ $lines -gt 10 ]]; then lines=10; fi

choice=$(ls $tmuxinator_folder | cut -d "." -f 1 | sort | rofi -dmenu -i -l $lines -theme $theme -w 50 -p "tmux:" -no-fixed-num-lines)

if [[ "$choice" == "" ]]; 
	then exit; 
fi

echo $choice
eval "alacritty -e bash -c \"echo -e '\e]2;$choice\007'; tmuxinator start '$choice'\""
