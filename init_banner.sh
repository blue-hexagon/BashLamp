#!/bin/bash
grep "#CONF_BANNER_SET=TRUE" ~/.bashrc 1>/dev/null
if [[ $? -eq 1 ]]; then
	dnf install -y ruby figlet
	wget https://github.com/busyloop/lolcat/archive/master.zip
	wget https://raw.githubusercontent.com/xero/figlet-fonts/master/3d.flf --directory-prefix=/usr/share/figlet/fonts/
	unzip master.zip
	cd lolcat-master/bin
	gem install lolcat
	rm -rf lolcat-master
	rm -rf master.zip
	echo '#CONF_BANNER_SET=TRUE' >> ~/.bashrc
	echo 'figlet -w 120 -f "/usr/share/figlet/fonts/3d.flf" "Ditzels LAMP" | lolcat' >> ~/.bashrc
	echo 'echo " Ditzels LAMP Server - Store Patter Betyder Undskyld" | lolcat' >> ~/.bashrc
fi