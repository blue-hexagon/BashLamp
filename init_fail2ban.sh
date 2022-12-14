#!/bin/bash    
grep "FAIL2BAN_INSTALLED" ${rcfile} 1>/dev/null
if [[ $? -eq 1 ]]; then
	print_yellow "To get help, consult: https://www.linode.com/docs/guides/using-fail2ban-to-secure-your-server-a-tutorial/"

	dnf install -y epel-release > /dev/null 2>&1
	print_green "[dnf] installed epel-release"

	dnf install -y fail2ban > /dev/null 2>&1
	print_green "[dnf] installed fail2ban"

	systemctl enable --now fail2ban > /dev/null 2>&1
	print_green "[systemctl] enabled and started fail2ban"

	print_green "[script] Beginning Fail2Ban Configuration"
	cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
	print_green "[script] Copyied fail2ban config"

	cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
	print_green "[script] Copyied fail2ban jail config"

	sed -i 's/backend = auto/backend = systemd/g' /etc/fail2ban/jail.local
	print_green "[sed] Changed backend from auto to systemd in /etc/fail2ban/jail.local"
	print_green "[script] executed successfully"
	echo "FAIL2BAN_INSTALLED" >> ${rcfile}
fi
