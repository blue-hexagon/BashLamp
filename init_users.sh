#!/bin/bash
for username in "${new_users[@]}"
do
    if ! id -u ${username} > /dev/null 2>&1; then
        adduser ${username}
        usermod -aG wheel ${username}
        passwd --stdin ${username} <<< ${users_password}
        print_green "${username} created with password: ${users_password}"
    else
        print_red "${username} already exists."
    fi
done
