#!/bin/bash
print_red () {
  echo -e "\e[91m$1\e[39m"
}

print_green () {
  echo -e "\e[92m$1\e[39m"
}

print_yellow () {
  echo -e "\e[93m$1\e[39m"
}


error_msg_and_exit()
{
    print_red "Error: $1"
    exit 1
}