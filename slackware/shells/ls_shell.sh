#!/bin/bash

set -euo pipefail

directory=$1

function by_date {
	clear
	echo "Dir: $directory"
	if [[ "$1" == "newest" ]]; then
		ls $directory -lt --time-style=+"%Y-%m-%d" | less
	elif [[ "$1" == "oldest" ]]; then
		ls $directory -ltr --time-style=+"%Y-%m-%d" | less
	else
		echo "Wrong parameter: newest|oldest" | false
	fi
	same_date=$(ls $directory -lt --time-style=+"%Y-%m-%d" | tail +2 | awk '{print $6}' | uniq -c | wc -l)
	echo "$same_date files share the same date"
	read
}

function by_size {
	clear
	if [[ "$1" == "largest" ]]; then
		ls $directory -lS | less
	elif [[ "$1" == "smallest" ]]; then
		ls $directory -lSr | less
	else
		echo "Wrong parameter: newest|oldest" | false
	fi
	same_date=$(ls $directory -lSr | tail +2 | awk '{print $5}' | uniq -c | wc -l)
	echo "$same_date files share the same date"
	read
}

function by_type {
	clear
	{
		ls $directory -l --time-style=+"%Y-%m-%d" | tail +2 | grep '^d'
		ls $directory -l --time-style=+"%Y-%m-%d" | tail +2 | grep '^-'
	} | less
	dir_count=$(ls $directory -l --time-style=+"%Y-%m-%d" | tail +2 | grep '^d' | wc -l)
	file_count=$(ls $directory -l --time-style=+"%Y-%m-%d" | tail +2 | grep '^-' | wc -l)
	echo "Number of directories: $dir_count"
	echo "Number of files: $file_count"
	read
}

function filter_by {
	clear
	extra_options=""
	read -p "Recursive? (y/n) " recursive
	read -p "String: " filter_str
	if [[ "$recursive" == "n" ]]; then
		extra_options="-maxdepth 1"
	fi
	if [[ "$1" == "startby" ]]; then
		find $directory $extra_options -name "$filter_str*" | less
	elif [[ "$1" == "contains" ]]; then
		find $directory $extra_options -name "*$filter_str*" | less
	elif [[ "$1" == "endsby" ]]; then
		find $directory $extra_options -name "*$filter_str" | less
	else
		echo "Wrong parameter: startby|contains|endsby" | false
	fi
	read
}

while true; do
	clear
	echo "Sort files: "
	echo "1. Newest to Oldest"
	echo "2. Oldest to Newest"
	echo "3. Largest to Smallest"
	echo "4. Smallest to Largest"
	echo "5. Filetype (directory/file)"
	echo "Filter Files: "
	echo "6. Display files/directories that start with a given string"
	echo "7. Display files/directories that end with a given string"
	echo "8. Display files/directories that contain a given string"
	echo "9. Change directory"
	echo "10. Exit"

	echo ""
	read -p "Choice: " option
	echo "$option"

	case $option in
		1)
			by_date newest
			;;
		2)
			by_date oldest
			;;
		3)
			by_size largest
			;;
		4)
			by_size smallest
			;;
		5)
			by_type
			;;
		6)
			filter_by startby
			;;
		7)
			filter_by contains 
			;;
		8)
			filter_by endsby
			;;
		9)
			read -p "Directory: " directory
			;;
		*)
			exit
			;;
	esac
done