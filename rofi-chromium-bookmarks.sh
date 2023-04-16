#1/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme.rasi"

bookmarks_path="$HOME/.config/chromium/Default/Bookmarks"

slected_bookmark=$(jq '.roots.bookmark_bar.children | map(.name)' $bookmarks_path | jq -r -c '.[]' | sort | rofi -dmenu -i -theme $theme -w 100 -p "Chroimum Bookmarks:")
if [[ "${slected_bookmark}" == "" ]]; then exit; fi
echo $slected_bookmark

selected_bookmark_url=$(jq -rc ".roots.bookmark_bar.children[] | select(.name==\"${slected_bookmark}\") | .url" $bookmarks_path)
if [[ "$selected_bookmark_url" == "" ]]; then exit; fi
echo $selected_bookmark_url

chromium $selected_bookmark_url;