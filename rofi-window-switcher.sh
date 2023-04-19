#!/bin/bash

## just a wrapper of the rofi window
## mode to use the same theme as other
## scripts

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme-large.rasi"

rofi -show window -theme $theme -display-window " Window:"