#!/bin/bash

ADD_OPTION="◯ add"
REMOVE_OPTION="◯ remove"

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme.rasi"

## get config from options
config_path=""
for (( i=1; i <= "$#"; i++ )); do
	case ${!i} in "-c" | "--config")
		value=$(($i + 1))
		echo $value
		config_path="${!value}"
		echo $config_path
		shift
	esac
done

## if no config in options, use default 
if [[ "$config_path" == "" ]]; then 
	config_path="${HOME}/.rofi-path-launcher.config.json"

	if [[ ! -f $config_path ]]; then 
		touch $config_path
		echo "{}" > $config_path
	fi
	
	config=$(cat $config_path)

	if [[ "$config" == "" ]]; then echo "{}" > $config_path; fi
fi
	
config=$(cat $config_path)

function get_program {
	programs_num=$({ echo $config | jq '. |= keys' | jq -r -c '.[]'; echo $ADD_OPTION; echo $REMOVE_OPTION; } | wc -l) 
	if [[ $programs_num -gt 10 ]]; then programs_num=10; fi
	program=$({ echo $config | jq '. |= keys' | jq -r -c '.[]' | sort; echo $ADD_OPTION; echo $REMOVE_OPTION; } | rofi -dmenu -i -theme $theme -l $programs_num -p " Path Launcher:")
	if [[ $program == $ADD_OPTION ]]; then add_program;
	elif [[ $program == $REMOVE_OPTION ]]; then remove_program;
	elif [[ $program != "" ]]; then get_program_path $program; 
	fi
}

function get_program_path {
	program="$1"
	
	pattern=".${program}.paths[]"
	lines_num=$({ echo $config | jq -r -c $pattern; echo $ADD_OPTION; echo $REMOVE_OPTION; } | wc -l)
	if [[ $lines_num -gt 10 ]]; then lines_num=10; fi
	path=$({ echo $config | jq -r -c $pattern | sort; echo $ADD_OPTION; echo $REMOVE_OPTION; }  | rofi -dmenu -i -theme $theme -l $lines_num -p " $program (path)")

	if [[ $path == "" ]]; then get_program;
	elif [[ $path == $ADD_OPTION ]]; then add_path_to_program $program;
	elif [[ $path == $REMOVE_OPTION ]]; then remove_path_from_program $program;
	else execute_command $1 $path;
	fi
}

function execute_command {
	program="$1"
	path="$2"

	pattern=".${program}.command"
	command=$(echo $config | jq -r $pattern)
	
	command="${command/"<path>"/$path}"
	eval $command
}

function add_path_to_program {
	program="$1"

	path=$(rofi -dmenu -i -theme $theme -l 0 -p " $program (add path)")

	if [[ "$path" == "" ]]
		then get_program_path $program
		else
			abs_path=${path/"~/"/"${HOME}/"}
			if [[ -d $abs_path ]] || [[ -f $abs_path ]]; then
				pattern=".${program}.paths + [\"${path}\"]"
				new_paths=$(jq "$pattern" $config_path)

				pattern=".${program}.paths = ${new_paths}"
				new_config=$(jq "$pattern" $config_path)

				echo $new_config > $config_path
				config=$(cat $config_path);
			else print_error "invalid path ($path)"; fi

			get_program_path $program
	fi
}

function remove_path_from_program {
	program="$1"

	lines_num=$(echo $config | jq -r -c $pattern | wc -l)
	if [[ $lines_num -gt 10 ]]; then lines_num=10; fi
	path=$(echo $config | jq -r -c $pattern | sort | rofi -dmenu -i -theme $theme -l $lines_num -p " $program (remove path)")

	if [[ "$path" != "" ]]; then
		confirm=$(ask_for_confirmation "$path")
		if [[ ${confirm,,} == "yes" ]]; then 
			pattern=".${program}.paths - [\"${path}\"]"
			new_paths=$(jq "$pattern" $config_path)

			pattern=".${program}.paths = ${new_paths}"
			new_config=$(jq "$pattern" $config_path)

			echo $new_config > $config_path
			config=$(cat $config_path)
		fi
	fi

	get_program_path $1
}

function add_program {
	program_name=$(rofi -dmenu -i -theme $theme -l 0 -p " Path Launcher (program name)")

	if [[ "$program_name" == "" ]]; 
		then get_program;
		else 
			program_command=$(rofi -dmenu -i -theme $theme -l 0 -p " Path Launcher (program cmd)")

			pattern=". + {\"${program_name}\":{\"command\":\"${program_command}\",\"paths\":[]}}"
			new_config=$(jq "$pattern" $config_path)

			echo $new_config > $config_path
			config=$(cat $config_path)

			get_program;
		fi
}

function remove_program {
	programs_num=$(echo $config | jq '. |= keys' | jq -r -c '.[]' | wc -l) 
	if [[ $programs_num -gt 10 ]]; then programs_num=10; fi
	program=$(echo $config | jq '. |= keys' | jq -r -c '.[]' | sort | rofi -dmenu -i -theme $theme -l $programs_num -p " Path Launcher (remove program):")

	if [[ "$program" != "" ]]; then 
		confirm=$(ask_for_confirmation "$program")
		if [[ ${confirm,,} == "yes" ]]; then 
			pattern="del(.\"$program\")"
			echo $pattern
			new_config=$(jq "$pattern" $config_path)

			echo $new_config
			echo $new_config > $config_path
			config=$(cat $config_path)
		fi
	fi

	get_program
}

function print_error {
	rofi -e "Error: $1" 
}

function ask_for_confirmation {
	echo $(rofi -dmenu -theme $theme -p " Confirm ($1) ? [yes/no]" -l 0)
}

get_program
