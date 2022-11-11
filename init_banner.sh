#!/bin/bash
grep "#CONF_BANNER_SET=TRUE" ~/.bashrc 1>/dev/null
if [[ $? -eq 1 ]]; then
	dnf install -y ruby figlet
	wget https://github.com/busyloop/lolcat/archive/master.zip
	wget https://raw.githubusercontent.com/xero/figlet-fonts/master/3d.flf --directory-prefix=/usr/share/figlet/fonts/
	unzip master.zip
	cd lolcat-master/bin
	gem install lolcat
	cd -
	#rm -rf lolcat-master
	#rm -rf master.zip
	echo 'figlet -w 120 -f "/usr/share/figlet/fonts/3d.flf" "Ditzels LAMP" | lolcat' >> ~/.bashrc
	echo 'echo " Ditzels LAMP Server - Store Patter Betyder Undskyld" | lolcat' >> ~/.bashrc
	echo "PS1='\[\e[0;38;5;46m\][\[\e[0;38;5;214m\]\u\[\e[0m\]@\[\e[0;38;5;205m\]\h \[\e[0;38;5;226m\]\w\[\e[0;38;5;46m\]]\[\e[0;1;38;5;214m\]\$\[\e[0m\]'" >> ~/.bashrc
	echo '#CONF_BANNER_SET=TRUE' >> ~/.bashrc
fi