#Automatic Updates for miniMIA


install_dir="/usr/bin/minimia-updater"
log="${install_dir}/log"
date=$(date +%D)
time=$(date +%r)

if ! test -f $log; then
	touch $log
fi

echo "miniMIA Update Script" > $log
echo "${date} ${time}" >> $log
printf "\n\n" >> $log

if [ "$EUID" -ne 0 ]; then 
	echo "Script was not ran as root! Exiting..." >> $log
	exit
fi

echo "Checking for updates..." >> $log
#check for updates
update=$(git -C $install_dir fetch --dry-run 2>&1)

if [ -z $update ]; then
	echo "No update found." >> $log
	#update is not required
	exit
fi

echo "Update found!" >> $log

git -C $install_dir pull >> $log
chmod +x "${isntall_dir}/*" >> $log

printf "\n\n" >> $log
echo "Running all update scripts..." >> $log
for script in *.sh; do
	echo "	Running Script ${script}..." >> $log
	/bin/bash "${script}"
done

echo "Update Finished Successfully!" >> $log
