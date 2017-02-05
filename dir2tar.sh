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

echo "By running this script, your directories will be deleted after making the archive."
read -p "Are you sure you want to execute this operation? (yes/no)" confirm

if [ $confirm != "yes" ]; then
	echo "=========================================="
	echo "The operation is terminated."
	echo "If this is not the expected result, you might have entered wrong confirmation letters. Make sure you enter 'yes' and not simply 'y'."
	exit
fi

counter=0  # for counting the number of items under operation

for item in *;do
	if [ -d "$item" ]; then
		((counter++))
		tar cvf "$item".tar "$item"  && rm -r "$item"
	fi
done



echo "=========================================="

if [ $counter == 0 ]; then
	echo "No directory found here!"
	echo "Exit without making any change"
else
	echo "The operation has finished!"
	echo "$counter item(s) were archived."
fi


