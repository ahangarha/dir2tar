#!/bin/bash

#   This is a script for archiving all the directories in the PWD
# and remove the directory after archiving.

#################################################################
### TO DO
# [ ] - improve the confirmation 
#       [ ] - It should ask again if the user has entered 'y'
#       [ ] - convert $confirm to lowercase for comparision
# [ ] - Add more comment (documentation)
# [ ] - add options for compression and verbose
# [ ] - add --help and --version

# [ ] - TEMPLATE
#################################################################

# Exit the script if there is no directory here
number_of_dir=$(ls -l | grep "^d" | wc -l)

if [ $number_of_dir == "0" ]; then
	echo "No directory is found here!"
	exit
fi


# Getting confirmation from user
echo "By running this script, the following directories will be deleted after making the archive."
echo "Running this command in HOME directory or at system root can make damage."
echo " "
echo "The operation will be performed on the following directories:"

#show the list of directories
for item in *;do
	if [ -d "$item" ]; then
		echo " - $item"
	fi
done

read -p "Are you sure you want to execute this operation? (yes/no)" confirm
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

counter=0  # for counting the number of items under operation

for item in *;do
	if [ -d "$item" ]; then
		((counter++))

		# Archive as tar and then delete
		tar cvf "$item".tar "$item"  && rm -r "$item"

		# Result prompt
		echo "____________________________________________"
		echo "$item >>>> DONE"
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


