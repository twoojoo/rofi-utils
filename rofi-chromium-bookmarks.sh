#1/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme.rasi"

function print_error {
	rofi -e "Error: $1" 
}

bookmarks_path="$HOME/.config/chromium/Default/Bookmarks"

slected_bookmark=$({ 
	echo $(jq '.roots.bookmark_bar.children | map(.name)' $bookmarks_path); 
	echo $(jq '.roots.other.children | map(.name)' $bookmarks_path); 
} | jq -r -c '.[]' | sort | rofi -dmenu -i -theme $theme -w 100 -p "Chroimum Bookmarks:")

if [[ "${slected_bookmark}" == "" ]]; then exit; fi
echo $slected_bookmark

selected_bookmark_url=$(jq -rc ".roots.bookmark_bar.children[] | select(.name==\"${slected_bookmark}\") | .url" $bookmarks_path)

if [[ "$selected_bookmark_url" == "" ]]; then
	echo "trying other"
	echo $(jq -rc ".roots.other.children[] | select(.name==\"${slected_bookmark}\") | .url" $bookmarks_path)
	selected_bookmark_url=$(jq -rc ".roots.other.children[] | select(.name==\"${slected_bookmark}\") | .url" $bookmarks_path)  
	echo $selected_bookmark_url
fi

echo $selected_bookmark_url
if [[ "$selected_bookmark_url" == "" ]]; then
	print_error "$slected_bookmark don't have a URL"
	exit
fi

chromium $selected_bookmark_url;