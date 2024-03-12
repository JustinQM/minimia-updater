#This is an example of how to make an update script for miniMIA

#1. DO NOT USE #!/bin/bash. The script is sourced directly from the updater

#2. Use the variables defined from update.sh to your advantage
#	$install_dir = Directory where the updater is installed
#	$date = Current Date

#3. Always use log instead of printing to stdout.
#	Ex. log "Hello World"

#4. If you need to pipe a commands output to log. First capture the output in a variable and then log it
#	Ex. command=${ls -l}; log $command


#Warnings
#1. Do NOT use exit as this will kill the updater. Instead use return.
#2. ALWAYS use absolute paths. Crontab does not run from within the install directory

#Example Script:

#Checking if the template file exists within the install directory
log "Checking if the template is within the install directory"
if test -f "${install_dir}/template.sh"; then
	log "Found Template! Removing!"
	rm "${install_dir}/template.sh"
	return
else
	log "Template not found"
	return
fi
