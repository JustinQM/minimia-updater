#!/bin/bash

#Constants
install_dir="/usr/bin/minimia-installer"
log="${install_dir}/log"
date=$(date +%D)
time=$(date +%r)

#Logging Function
function log
{
	if [ -z "${1}" ]; then
		return
	fi

	time=$(date +%r)
	printf "[${time}] ${1}\n" >> $log
}

if ! test -f $log; then
	touch $log
fi

echo "miniMIA Update Script" > $log #clears log
echo "${date} ${time}" >> $log

if [ "$EUID" -ne 0 ]; then 
	log "Script was not ran as root! Exiting..."
	exit
fi

printf "\n" >> $log

log "Checking for updates..."
update=$(git -C $install_dir fetch --dry-run 2>&1)

if [ -z "${update}" ]; then
	log "No update found."
	#update is not required
	exit
fi

log "Update found!"

git -C $install_dir stash
download=$(git -C $install_dir pull 2>&1)
log $download
log "chmod +x directory..."
chmod +x "${install_dir}/*"

printf "\n" >> $log
log "Running all update scripts..."
for script in *.sh; do
	if [ $script = "update.sh" ]; then
		continue
	fi

	printf "\n" >> $log #manual formating to make the log more clear
	log "Running Script ${script}:"
	source "${script}"
	log "Finished Script ${script}\n"
done

log "Copying Log File to Mia User Home Directory"
cp -f $log /home/mia/.log
log "Update Finished Successfully!"
