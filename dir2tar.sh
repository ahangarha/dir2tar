#!/bin/bash

#   This is a script for archiving all the directories in the PWD
# and remove the directory after archiving.

### Todo List ###################################################
#
# [ ] make interactive mode functional
#
#################################################################


#!/bin/bash

showHelp() {
	echo "This script will take all the directories within the working directory and archive them useing 'tar' and then deletes them.
	
  Warning:
    As you confirm the execution of this script, there
    would be no way to undo the removal of the directories
    except using data recovery methods which has its
    own risks.
    So make sure you know what you are doing.

  Usage:
    dir2tar [OPTION]

  Options:
  -h    Help
        This option Shows help (what you currently see)

  -z    Compression on
        Compress the archive useing gZip
        By using this option, the archive extension will
        become '.tar.gz.'
        Notice that performing compression will increase
        the duration of script execution. This duration
        depends on the content of each directory.

  -v    Verbose
        This option make the script show more
        information while execution.

  -i    Interactive mode
        In this mode, the user will be asked to confirm
        the operation on each directory.
"
	
	exit
}

init(){
	tarOption='cf'
	tarExtension='.tar'

	if [ $verbose == 1 ]; then
			tarOption="v$tarOption"
	fi
	if [ $compression == 1 ]; then
			tarOption="z$tarOption"
			tarExtension="$tarExtension.gz"
	fi
}


verbose=0
compression=0
interactive=0
confirm=0

# Recognizing OPTIONS and perform related actions
while getopts "hvziy" options; do
	case "$options" in
		h)
			showHelp ;;
		v)
			verbose=1 ;;
		z)
			compression=1 ;;
		i)
			interactive=1 ;; # Still this option has no effect
		y)
			confirm="yes" ;;
	esac
done

# Run init function to set basic variables
init 

# Exit the script if there is no directory here
number_of_dir=$(ls -l | grep "^d" | wc -l)

if [ $number_of_dir == "0" ]; then
	echo "No directory is found here!"
	exit
fi

if [ $confirm != "yes" ]; then

	# Getting confirmation from user
	echo "By running this script, the following directories will be
	deleted after making the archive. Running this command in HOME 
	directory or at system root can make damage.
	
	The operation will be performed on the following directories:"
	
	#show the list of directories
	for item in *;do
		if [ -d "$item" ]; then
			echo " - $item"
		fi
	done
	
	echo " " # add one more blank line`
	read -p "Are you sure? (yes/no) " confirm
	# make sure that $confirm is all lowercase
	confirm=$(echo "$confirm" | sed 's/.*/\L&/')
	
	if [ $confirm != "yes" ]; then
		# Give another opportunity if the user has entered 'y'. Otherwise, assume 'no'
		if [ $confirm != "y" ];then
			exit
		else
			echo "To confirm, type 'yes' and not simply 'y'."
			read -p "Are you sure you want to execute this operation? (yes/no)" confirm
			# make sure that $confirm is all lowercase
			confirm=$(echo "$confirm" | sed 's/.*/\L&/')
	
			if  [ $confirm != "yes" ]; then
				exit
			fi
		fi
	fi
fi

counter=0  # for counting the number of items under operation

for item in *;do
	if [ -d "$item" ]; then
		((counter++))

		# Archive as tar and then delete
		# tar cvf "$item".tar "$item"  && rm -r "$item" <<<< Old line
		tar "$tarOption" "$item""$tarExtension" "$item"  && rm -r "$item"

		# Result prompt (verbos)
		if [ $verbose == 1 ]; then
				echo "$item >>>> DONE"
				echo "____________________________________________"
		fi
	fi
done



echo "=========================================="

if [ $counter == 0 ]; then
	echo "No directory found here!"
	echo "Exit without making any change."
else
	echo "The operation has finished!"
	echo "$counter item(s) were archived."
fi


