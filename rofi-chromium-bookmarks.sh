#1/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme.rasi"

function print_error {
	rofi -e "Error: $1" 
}


## parse options

bookmarks_path="$HOME/.config/chromium/Default/Bookmarks"
browser="chromium"
debug=false

for (( i=1; i <= "$#"; i++ )); do
	case ${!i} in 
		"-f" | "--bookmarks-file")
			value=$(($i + 1))
			bookmarks_path="${!value}"
			if [[ "$bookmarks_path" == "" ]]; then 
				print_error "a file path must be provided along with the option -f|--bookmarks-file"
				exit
			fi
			;;

		"-b" | "--alt-browser")
			value=$(($i + 1))
			browser="${!value}"
			if [[ "$browser" == "" ]]; then 
				print_error "a browser name must be provided along with the option -b|--alt-browser"
				exit
			fi
			;;

		"-d" | "--debug")
			debug=true
			;;
	esac
done

slected_bookmark=$({ 
	echo $(jq '.roots.bookmark_bar.children | map(.name)' $bookmarks_path); 
	echo $(jq '.roots.other.children | map(.name)' $bookmarks_path); 
} | jq -r -c '.[]' | sort | rofi -dmenu -i -theme $theme -w 100 -p "Chroimum Bookmarks:")

if [[ $debug == true ]]; then echo "#> selected bookmark name: $slected_bookmark"; fi
if [[ "${slected_bookmark}" == "" ]]; then exit; fi

if [[ $debug == true ]]; then echo "#> looking in bookmark_bar folder"; fi
selected_bookmark_url=$(jq -rc ".roots.bookmark_bar.children[] | select(.name==\"${slected_bookmark}\") | .url" $bookmarks_path)

if [[ "$selected_bookmark_url" == "" ]]; then
	if [[ $debug == true ]]; then echo "#> looking in other bookmarks folder"; fi
	selected_bookmark_url=$(jq -rc ".roots.other.children[] | select(.name==\"${slected_bookmark}\") | .url" $bookmarks_path)  
fi

if [[ $debug == true ]]; then echo "#> selected bookmark url: $selected_bookmark_url"; fi
if [[ "$selected_bookmark_url" == "" ]]; then
	print_error "$slected_bookmark don't have a URL"
	exit
fi

command="$browser $selected_bookmark_url"
if [[ $debug == true ]]; then echo "#> running: $command"; fi
eval $command & exit