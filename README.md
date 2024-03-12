![miniMIA](https://ranthos.com/u/2024-03/minimia.png)

# miniMIA Updater

## About
This repository is a collection of update scripts that automatically get ran by a driver shell script (update.sh) at a specified time.

## Default Usage
Any shellscript within the root directory of the repo will be run at 3am daily.

## Creating Custom Scripts
Copy the template and read the guidelines inside the template to create your own scripts.

## Adding Custom Scripts
If you want to add your custom scripts to your miniMIA, you can fork the autoupdater and subsitite the offical repo with your own.
1. Fork this Repo

2. SSH into your miniMIA
```
ssh mia@mamamia
```

3. Login to root
```
su
```

4. Change directory to /usr/bin
```
cd /usr/bin
```

5. Delete the offical minimia-updater
```
rm -rf ./minimia-updater
```

6. Clone your fork of the minimia-updater
```
git clone https://github.com/mia/minimia-updater.git
```
> [!WARNING]
> Unless you login to your Github account with the root user, the Github Repo must be public and cloned with HTTPS.

7. Manually change execute permissions on all scripts
```
chmod -R +x ./minimia-updater
```
## Modify Crontab
To modify the time of day the update script runs, edit /etc/crontab as root. The default entry is
```
0 3 * * * root /usr/bin/minimia-updater/update.sh
```
Read about crontab's formatting [here](https://wiki.archlinux.org/title/cron#Crontab_format)
> [!NOTE]
> You may notice the format listed on the wiki has 6 parameters instead of 7 like miniMIA does.  
> This is because most cronjobs are assigned to a user while they are created. Usually by using the command crontab -e.  
>  miniMIA's crontabs are instead created as a system crontab, which has no association to a user.  
>  This is why we must specify the user that will run the script as the 6th argument (root in this case).  
