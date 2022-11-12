#!/bin/bash    
grep "LAMP_INSTALLED" ${rcfile} 1>/dev/null
if [[ $? -eq 1 ]]; then
	dnf install -y httpd
	systemctl enable --now httpd
	print_green "[dnf] Apache installed, enabled and started"
	print_green "[systemctl] Apache enabled and started"

	firewall-cmd --add-service=http --permanent
	firewall-cmd --add-service=https --permanent
	firewall-cmd --add-service=ftp --permanent
	firewall-cmd --reload
	print_green "[firewalld] http, https and ftp added to firewall rules"
	print_green "[firewalld] reloaded"

	dnf install -y mariadb-server mariadb
	systemctl enable --now mariadb
	print_green "[dnf] mariadb and mariadb-server installed"
	print_green "[systemctl] mariadb enabled and started"

	dnf module reset php -y
	dnf module install php:7.4 -y
	dnf install php-curl php-zip -y
	print_green "[dnf] php:7.4 installed"

	echo "<?php phpinfo(); ?>" > /var/www/html/info.php
	echo "<html><body><h1>Hello ZBC!</h1></body></html>" > /var/www/html/hello.html
	print_green "[www] added info page and helloworld page to /var/www/html/"

	systemctl restart httpd
	print_green "[systemctl] Apache restarted"
	print_green "[script] LAMP installed successfully"
	print_green "[script] Securing database"
	mysql -sfu root <<-EOS
	-- set root password
	UPDATE mysql.user SET Password=PASSWORD('Kode1234!') WHERE User='root';
	-- delete anonymous users
	DELETE FROM mysql.user WHERE User='';
	-- delete remote root capabilities
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	-- drop database 'test'
	DROP DATABASE IF EXISTS test;
	-- also make sure there are lingering permissions to it
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	-- make changes immediately
	FLUSH PRIVILEGES;
	EOS
	echo "LAMP_INSTALLED" >> ${rcfile}
fi