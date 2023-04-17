#!/bin/bash

script_path=$(realpath "$0")
script_name=$(echo $0 | rev | cut -d "/" -f1 | rev)
script_dir="${script_path/$script_name/""}"
theme="${script_dir}theme.rasi"

config_path="$HOME/.rofi-todo-list.config.json"

function select_pending_task {
	lines=$({ jq ".pending[]" $config_path; echo "◯ add task"; echo "◯ completed list"; } | wc -l)
	if [[ $lines -gt 10 ]]; then lines=10; fi
	task=$({ jq -rc ".pending[]" $config_path; echo "◯ add task"; echo "◯ completed list"; } | rofi -dmenu -l $lines -theme $theme -p " Tasks (pending):")

	if [[ "$task" == "" ]]; then exit; 
	elif [[ "$task" == "◯ add task" ]]; then add_new_task
	elif [[ "$task" == "◯ completed list" ]]; then select_completed_task
	else select_pending_task_action "$task"
	fi
}

function select_completed_task {
	lines=$({ jq ".completed[]" $config_path; echo "◯ prune completed tasks"; } | wc -l)
	if [[ $lines -gt 10 ]]; then lines=10; fi
	task=$({ jq -rc ".completed[]" $config_path; echo "◯ prune completed tasks";  } | rofi -dmenu -l $lines -theme $theme -p " Tasks (completed):")
 
	if [[ "$task" == "◯ prune completed tasks" ]]; then prune_completed_tasks; fi
	select_pending_task; 
}

function select_pending_task_action {
	action=$(echo "◯ complete
◯ delete" | rofi -dmenu -theme $theme -l 2 -p " Tasks ($1):")

	if [[ "$action" != "" ]]; then
		if [[ "$action" == "◯ complete" ]]; then complete_task "$1"; fi
		if [[ "$action" == "◯ delete" ]]; then delete_task "$1"; fi
	fi

	select_pending_task
} 

function add_new_task {
	task="$(rofi -dmenu -theme $theme -l 0 -p " Tasks (new):")"
	if [[ "$task" != "" ]]; then add_task "$task"; fi
	select_pending_task
} 

function add_task {
	if [[ "$1" != "" ]]; then
		pattern=".pending + [\"${1}\"]"
		new_config=$(jq "$pattern" $config_path)

		pattern=".pending = ${new_config}"
		new_config=$(jq "$pattern" $config_path)

		echo $new_config > $config_path
	fi
}

function prune_completed_tasks {
	pattern=".completed = []"
	pruned=$(jq "$pattern" $config_path)
	echo $pruned > $config_path
}

function complete_task {
	pattern=".pending - [\"${1}\"]"
	new_tasks=$(jq "$pattern" $config_path)

	pattern=".pending = ${new_tasks}"
	new_tasks=$(jq "$pattern" $config_path)

	echo $new_tasks > $config_path

	pattern=".completed + [\"${1}\"]"
	new_tasks=$(jq "$pattern" $config_path)

	pattern=".completed = ${new_tasks}"
	new_tasks=$(jq "$pattern" $config_path)

	echo $new_tasks > $config_path
}

function delete_task {
	pattern=".pending - [\"${1}\"]"
	new_tasks=$(jq "$pattern" $config_path)

	pattern=".pending = ${new_tasks}"
	new_tasks=$(jq "$pattern" $config_path)
	
	echo $new_tasks > $config_path
}

select_pending_task