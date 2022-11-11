#!/bin/bash

source func_require_root.sh
source config.sh
source func_colors.sh
source func_utilities.sh

print_green "[dnf] Updating system"
dnf update -y

print_green "[dnf] Installing: epel-release"
dnf install -y epel-release
print_green "[dnf] Installing: vim, tmux, byobu and wget"
dnf install -y vim tmux wget byobu dialog

source init_alias.sh
source init_banner.sh
source init_users.sh
source init_lamp.sh
source init_fail2ban.sh
source init_wordpress.sh
source init_vsftpd.sh