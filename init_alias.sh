#!/bin/bash
grep 'ALIASES_CONFIGURED' ${rcfile} 1>/dev/null
if [[ $? -eq 1 ]]; then
	print_green "[ditzel] adding aliases to .bashrc"
	cat <<-ALIASLIST >>~/.bashrc
		alias cls="clear"
		alias ls='ls -liah --color=auto'
		alias grep='grep --color=auto'
		alias egrep='egrep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias vi=vim
		alias ping='ping -c 5'
		alias fping='ping -c 100 -s.2'
		alias ports='netstat -tulanp'
		alias curlheader='curl -I'
		alias df='df -H'
		alias du='du -ch'
		alias diff="diff --color=auto --suppress-common-lines -y"
		alias eip="curl ipinfo.io/ip"
	ALIASLIST
	echo "ALIASES_CONFIGURED" >> ${rcfile}
else
	print_yellow "[ditzel] aliases already added to .bashrc"
fi