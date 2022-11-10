#!/bin/bash    
source func_colors.sh
source func_require_root.sh


print_yellow "To get help, consult: https://www.linode.com/docs/guides/using-fail2ban-to-secure-your-server-a-tutorial/"
dnf update -y > /dev/null 2>&1
print_green "[dnf] system is updated"
dnf install -y epel-release > /dev/null 2>&1
print_green "[dnf] installed epel-release"


dnf install -y fail2ban > /dev/null 2>&1
print_green "[dnf] installed fail2ban"


systemctl enable --now fail2ban > /dev/null 2>&1
print_green "[systemctl] enabled and started fail2ban"

# === Fail2Ban Configuration ===
print_green "[script] Beginning Fail2Ban Configuration"

cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
print_green "[script] Copyied fail2ban config"

cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
print_green "[script] Copyied fail2ban jail config"

sed -i 's/backend = auto/backend = systemd/g' /etc/fail2ban/jail.local
print_green "[sed] Changed backend from auto to systemd in /etc/fail2ban/jail.local"
print_green "[script] executed successfully"

read -p "Open /etc/fail2ban/jail.local to modify the config? (y/n): " choice

if [[ ${choice,,} == "y" || ${choice,,} == "yes" || ${choice} == "" ]]
then
        vim /etc/fail2ban/jail.local
fi
