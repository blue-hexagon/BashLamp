#!/bin/bash
source func_colors.sh

$password="Kode1234!"   

for username in tobi801j tobi802j stef965j mort46n1
do
    if ! id -u ${username} > /dev/null 2>&1; then
        adduser ${username}
        usermod -aG wheel ${username}
        passwd --stdin ${username} <<< ${password}
        print_green "${username} created with password: ${password}"
    else
        print_red "${username} already exists."
    fi
done
