#!/bin/bash    
grep ${rcfile} "WORDPRESS_INSTALLED" 1>/dev/null
if [[ $? -eq 1 ]]; then
	db_name="wordpress"
	db_password="password"
	db_user="wpuser"

	print_yellow "To get help, consult: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-centos-7"

	print_green "[mysql] Creating WordPress database with databasename: ${db_name}"
	mysql -u root -pKode1234! -e "CREATE DATABASE ${db_name};"
	print_green "[mysql] Creating user in database: ${db_user} with password: ${db_password}"
	mysql -u root -pKode1234! -D wordpress -e "CREATE USER ${db_user}@localhost IDENTIFIED BY '${db_password}';"
	mysql -u root -pKode1234! -D wordpress -e "GRANT ALL PRIVILEGES ON wordpress.* TO ${db_user}@localhost IDENTIFIED BY '${db_password}';"
	mysql -u root -pKode1234! -D wordpress -e "FLUSH PRIVILEGES;"

	print_green "[dnf] Installing php-gd and php-mysqlnd"
	dnf install -y php-gd php-mysqlnd

	print_green "[systemctl] Restarting httpd"
	systemctl restart httpd
	cd ~
	print_green "[wget] Downloading latest WordPress release"
	wget http://wordpress.org/latest.tar.gz
	print_green "[tar] Unpacking WordPress tarball"
	tar xzvf latest.tar.gz >/dev/null 2>&1

	print_green "[system] Finishing up WordPress install"
	sudo rsync -avP ~/wordpress/ /var/www/html/ >/dev/null 2>&1
	mkdir /var/www/html/wp-content/uploads
	sudo chown -R apache:apache /var/www/html/*

	print_green "[system] Finishing up WordPress configuration"
	echo -e "Configuring wordpress"
	cd -
	cd /var/www/html
	cp wp-config-sample.php wp-config.php
	print_green "[system] Setting db_name: ${db_name}, username: ${db_user} and password: ${db_password} in wp-config.php"
	sed -i "s/database_name_here/${db_name}/g" wp-config.php
	sed -i "s/username_here/${db_user}/g" wp-config.php
	sed -i "s/password_here/${db_password}/g" wp-config.php
	cd -

	cd /var/www/html/wp-content/plugins/
	wget https://downloads.wordpress.org/plugin/woocommerce.7.1.0.zip
	unzip woocommerce.7.1.0.zip
	cd -
	echo "WORDPRESS_INSTALLED" >> ${rcfile}
fi
