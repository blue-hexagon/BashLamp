#!/bin/bash
grep 'SYSTEM_UPDATED' ${rcfile} 1>/dev/null
if [[ $? -eq 1 ]]; then
	print_green "[dnf] Updating system"
	dnf update -y
	echo "SYSTEM_UPDATED" >> ${rcfile}
fi

grep 'BASE_SOFTWARE_INSTALLED' ${rcfile} 1>/dev/null
if [[ $? -eq 1 ]]; then
	print_green "[dnf] Installing: epel-release"
	dnf install -y epel-release
	print_green "[dnf] Installing: vim, tmux, byobu and wget"
	dnf install -y vim tmux wget byobu
	echo "BASE_SOFTWARE_INSTALLED" >> ${rcfile}
fi
