#!/bin/bash

#   This is a script for archiving all the directories in the PWD
# and remove the directory after archiving.

#################################################################
### TO DO
# [*] - use git
# [*] - Warn and get confirmation from the user
# [ ] - Add more comment (documentation)
# [ ] - add options for compression and verbose
# [ ] - add --help and --version

# [ ] - TEMPLATE
#################################################################

# Getting confirmation from user
echo "By running this script, your directories will be deleted after making the archive."
echo "Running this command in HOME directory or at system root can make damage."
read -p "Are you sure you want to execute this operation? (yes/no)" confirm

if [ $confirm != "yes" ] && [ $confirm != "YES" ]; then
	echo "To confirm, type 'yes' and not simply 'y'."
	read -p "Are you sure you want to execute this operation? (yes/no)" confirm

	if  [ $confirm != "yes" ] && [ $confirm != "YES" ]; then
		echo "____________________________________________"
		echo "The operation was not confirmed by the user!"
		exit
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


