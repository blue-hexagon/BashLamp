#!/bin/bash
source func_colors.sh
   
for username in tobi801j tobi802j stef965j mort46n1
do
    if ! id -u ${username} > /dev/null 2>&1; then
        adduser ${username}
        usermod -aG wheel ${username}
        passwd --stdin ${username} <<< "Kodeord1234!"
        echo -e "\e[92m${username} created with password: Kode1234!\e[39m"
    else
        echo -e "\e[91m${username} already exists.\e[39m"
    fi
done
