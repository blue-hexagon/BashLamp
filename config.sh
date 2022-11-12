#!/bin/bash
selection=$(dialog --title "Menu" --clear --cancel-label "Exit" \
    --menu "Please select:" 20 70 4 \
    "1" "Run installer" \
    "2" "Configure Fail2Ban" \
    "3" "Configure VSFTPD" \
 3>&1 1>&2 2>&3)
clear

if [[ $selection -eq 1 ]]; then
	rcfile_entries=$( wc -l "${HOME}/.ditzelrc" )
	rcfile_entries=($rcfile_entries)
	if [[ ${rcfile_entries[0]} -eq 8 ]]; then
		print_red "You have already installed the LAMP server with all of it's modules, exiting"
		exit 1
	fi
elif [[ $selection -eq 2 ]]; then
	grep "FAIL2BAN_INSTALLED" $rcfile 
	if [[ $? -eq 0 ]]; then
      	vim /etc/fail2ban/jail.local
		exit 0
	else
		print_red "You haven't run the setup for vsftpd yet, exiting"
		exit 1
	fi
elif [[ $selection -eq 3 ]]; then
	grep "VSFTPD_INSTALLED" $rcfile
	if [[ $? -eq 0 ]]; then
		vim /etc//vsftpd/vsftpd.conf
		systemctl restart vsftpd || systemctl reload vsftpd
		exit 0
	else
		print_red "You haven't run the setup for vsftpd yet, exiting"
		exit 1
	fi
fi


dialog --title "DitzelsLAMP" --msgbox 'This script will setup Fail2Ban and install a LAMP server with Wordpress and FTP access. For more information visit: https://github.com/blue-hexagon/BashLamp' 20 70
form_new_users="$(dialog --inputbox "Enter a list of users to create (space delimited)" 		   20 70 "" 3>&1 1>&2 2>&3)"
form_ftp_users="$(dialog --inputbox "Add users allowed to ftp into the server (space delimited)"   20 70 "" 3>&1 1>&2 2>&3)"
form_users_password="$(dialog --inputbox "Add a default password for the new users"  		   20 70 "" 3>&1 1>&2 2>&3)"

form_wordpress_db="$(dialog --form "Enter wp database details (no spaces!)"   20 70  14    \
             "Wordpress Database Name: "         1 1 "wordpress" 1  35  35  0 \
             "Wordpress Database Password: "     2 1 "password"  2  35  35  0 \
             "Wordpress Database User: "         3 1 "wpuser"    3  35  35  0 \
             3>&1 1>&2 2>&3)"
clear

new_users=($form_new_users)
ftp_users=($form_ftp_users)
users_password=$form_users_password

wordpress_db=($form_wordpress_db)
wordpress_db_name=${wordpress_db[0]}
wordpress_db_password=${wordpress_db[1]}
wordpress_db_user=${wordpress_db[2]}

if [[ ! getenforce == "Enforcing" ]]; then
	setenforce 1
fi
