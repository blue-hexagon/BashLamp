#!/bin/bash
set -e

source func_require_root.sh
echo -e "\e[92m[dnf] Updating system\e[39m"
dnf update -y 1>/dev/null

echo -e "\e[92m[dnf] Installing: vim, tmux, byobu and wget\e[39m"
dnf install -y vim tmux wget byobu 1>/dev/null

source init_alias.sh
source init_banner.sh
source init_users.sh
source init_lamp.sh
source init_fail2ban.sh
source init_wordpress.sh
source init_vsftpd.sh

set +e