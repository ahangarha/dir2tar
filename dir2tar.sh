#!/bin/bash

#   This is a script for archiving all the directories in the PWD
# and remove the directory after archiving.

#################################################################
### TO DO
# [ ] - use git
# [ ] - Add more comment (documentation)
# [ ] - Warn and get confirmation from the user
# [ ] - add options for compression and verbose
# [ ] - add --help and --version

# [ ] - TEMPLATE
#################################################################


counter=0  # for counting the number of items under operation

for item in *;do
	if [ -d "$item" ]; then
		((counter++))
		tar cvf "$item".tar "$item"  && rm -r "$item"
	fi
done

echo "=========================================="
echo "The operation has finished!"
echo "$counter item(s) were archived."
