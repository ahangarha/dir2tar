### Intro
This is a simple script to manage archiving directories as a .tar file. This script has come to existance because of a personal need and enthusiasm. 

The aim here is to archive and then remove the directory from the folder in which the script is being run.

By now, the script looks for all directories within the PWD (Present Working Directory) and make an archive file from each. By default, it makes the file with the same name and '.tar' extention, with no compression. If the process ends with no error, it removes the directory.

### TO DO
 - [x] Warn the user and get her confirmation before running the script
 - [ ] Show a summery of what would be affected by running the script
 - [ ] Show a brief report after completion of operation on each directory
 - [ ] Error management
       Make sure the the operation is done as expected
 - [ ] Improve documentation
 - [ ] Add `-h --help` option
 - [ ] Add `-v --verbose` and `-z --compress` options
 - [ ] Add `-i --interactive` option
       To get confirmation from the user before working on each directory

### Contribution
Any contribution would be welcome. Just since this is an excuse for me to develop my skills, I need to keep the process slow.

Thanks
