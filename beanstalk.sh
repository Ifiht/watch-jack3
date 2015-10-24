#!/bin/bash
# 0  No color
# 1  Orange
# 2  Red
# 3  Yellow
# 4  Blue
# 5  Purple
# 6  Green
# 7  Gray
COLOR=1
UNCOLOR=0
HOMEBASE=$(pwd)

if [ "$#" -lt "1" ]
    then echo "Error: Incorrect number of arguments.
    -h for help"
    exit 1;
elif [ "$#" -gt "2" ]
	then echo "Error: Incorrect number of arguments.
    -h for help"
    exit 1;
fi

if [ -e ./ignore.txt ]
	then
	ignore=$(cat ignore.txt | tr '\r\n' '|')
fi


if [ "$#" -eq "1" ]
    then
#################### UPDATE #############################
	if [ "$1" = "-u" ] || [ "$1" = "--update" ]
		then
		if [ -e ./golden_harp.txt ]
			then
			STARTPATH=$(head -1 ./golden_harp.txt)
			find $STARTPATH -not -path "*.*/*" -not -path "/Volumes/*" -not -path $HOMEBASE 2>/dev/null 1>./tmp.txt
			comm -23 <(sort ./tmp.txt) <(sort ./golden_harp.txt) | grep -v -E "$ignore" > ./giants_stew.txt
			rm -f ./tmp.txt
			while read line
			do
				if [ -e "$line" ]
					then
					osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$line\" to $COLOR" 1&2>/dev/null
				fi
			done < ./giants_stew.txt
			exit 0;
		else
			echo "Baseline file not present, exiting."
			exit 2;
		fi
#################### REMOVE #############################
	elif [ "$1" = "-r" ] || [ "$1" = "--remove" ]
		then
			while read line
			do
				if [ -e "$line" ]
					then
					osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$line\" to $UNCOLOR" 1&2>/dev/null
				fi
			done < ./giants_stew.txt
		exit 0;
#################### HELP #############################
	elif [ "$1" = "-h" ] || [ "$1" = "--help" ]
		then echo "Jack the Watcher v1.0
		Usage:
			$0 [Flag] [Target Directory]
		Commands:
			-b, --baseline			baselines a directory
			-u, --update			labels files created since the baseline
			-r, --remove			removes all labels
		Special Instructions:
			To ignore all files in a specific directory, create a file called 'ignore.txt' in the same file as the script, and include a list of line-deliminated full paths of the directories to ignore.
			Make sure to execute the script from within the directory where it resides!!!
			"
	else
		echo "Error: Invalid argument.
	    -h for help"
	    exit 3;
	fi
#################### BASELINE ###########################
elif [ "$#" -eq "2" ]
	then
	if [ "$1" = "-b" ] || [ "$1" = "--baseline" ]
		then
		find $2 -not -path "*.*/*" -not -path "/Volumes/*" -not -path $HOMEBASE 2>/dev/null 1>./golden_harp.txt
		exit 0;
	else
		echo "Error: Invalid argument.
	    -h for help"
	    exit 3;
	fi
fi



