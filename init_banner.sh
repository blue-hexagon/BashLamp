#!/bin/bash
grep ${rcfile} "BANNER_CONFIGURED" 1>/dev/null
if [[ $? -eq 1 ]]; then
	dnf install -y ruby figlet
	wget https://github.com/busyloop/lolcat/archive/master.zip || error_msg_and_exit "Failed retrieving lolcat"
	wget https://raw.githubusercontent.com/xero/figlet-fonts/master/3d.flf --directory-prefix=/usr/share/figlet/fonts/ || error_msg_and_exit "Failed retrieving custom figlet font"
	unzip master.zip
	cd lolcat-master/bin
	gem install lolcat
	cd -
	#rm -rf lolcat-master
	rm -rf master.zip
	echo 'figlet -w 120 -f "/usr/share/figlet/fonts/3d.flf" "Ditzels LAMP" | lolcat' >> ~/.bashrc
	echo 'echo " Ditzels LAMP Server - Store Patter Betyder Undskyld" | lolcat' >> ~/.bashrc
	echo "PS1='\[\e[0;38;5;46m\][\[\e[0;38;5;214m\]\u\[\e[0m\]@\[\e[0;38;5;205m\]\h \[\e[0;38;5;226m\]\w\[\e[0;38;5;46m\]]\[\e[0;1;38;5;214m\]\$\[\e[0m\]'" >> ~/.bashrc
	echo 'BANNER_CONFIGURED' >> ${rcfile}
	print_green "[ditzel] configured banner"
else
	print_green "[ditzel] banner already configured"
fi