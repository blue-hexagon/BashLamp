#!/bin/bash
form_new_users="$(dialog --inputbox "Enter a list of users to create (space delimited)" 		   20 70 "" 3>&1 1>&2 2>&3)"
form_ftp_users="$(dialog --inputbox "Add users allowed to ftp into the server (space delimited)"   20 70 "" 3>&1 1>&2 2>&3)"
form_users_password="$(dialog --inputbox "Add a default password for the new users"  		   20 70 "" 3>&1 1>&2 2>&3)"

form_worpress_db="$(dialog --form "Enter wp database details (no spaces!)"   20 70  14    \
             "Wordpress Database Name: "         1 1 "wordpress" 1  35  35  0 \
             "Wordpress Database Password: "     2 1 "password"  2  35  35  0 \
             "Wordpress Database User: "         3 1 "wpuser"    3  35  35  0 \
             3>&1 1>&2 2>&3)"


new_users=($form_new_users)
ftp_users=($form_ftp_users)
users_password=$form_users_password

wordpress_db=($form_wordpress_db)
wordpress_db_name=${wordpress_db[0]}
wordpress_db_password=${wordpress_db[1]}
wordpress_db_user=${wordpress_db[2]}

rcfile=~/.ditzelrc
if [[ ! -e ${rcfile} ]]; then
	touch ${rcfile}
fi

if [[ ! getenforce == "Enforcing" ]]; then
	setenforce 1
fi

clear

