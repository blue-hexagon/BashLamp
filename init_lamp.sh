#!/bin/bash    
source func_colors.sh

dnf update -y
print_green "[dnf] System updated"
dnf install -y vim tmux wget
print_green "[dnf] wget, vim and tmux installed"

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

read -p "Run mysql_secure_installation? (y/n): " choice

if [[ ${choice,,} == "y" || ${choice,,} == "yes" || ${choice} == "" ]]
then
        mysql_secure_installation
fi
print_green "[script] executed successfully"