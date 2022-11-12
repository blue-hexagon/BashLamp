#!/bin/bash
rcfile=~/.ditzelrc
if [[ ! -e ${rcfile} ]]; then
	touch ${rcfile}
fi
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
	print_green "[dnf] Installing: vim, tmux, expect, byobu and wget"
	dnf install -y vim wget dialog expect tmux byobu 
	echo "BASE_SOFTWARE_INSTALLED" >> ${rcfile}
fi
