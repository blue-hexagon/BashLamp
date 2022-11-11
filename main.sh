#!/bin/bash

setenforce 1

read -p "Run strict install mode with: set -e ? (y/n): " strictmode

if [[ ${strictmode,,} == "y" || ${strictmode,,} == "yes" || ${strictmode} == "" ]]
then
        set -e
fi

source func_require_root.sh

echo -e "\e[92m[dnf] Updating system\e[39m"
dnf update -y

echo -e "\e[92m[dnf] Installing: epel-release\e[39m"
echo -e "\e[92m[dnf] Installing: vim, tmux, byobu and wget\e[39m"
dnf install -y epel-release
dnf install -y vim tmux wget byobu

source init_alias.sh
source init_banner.sh
source init_users.sh
source init_lamp.sh
source init_fail2ban.sh
source init_wordpress.sh
source init_vsftpd.sh

if [[ ${strictmode,,} == "y" || ${strictmode,,} == "yes" || ${strictmode} == "" ]]
then
        set +e
fi