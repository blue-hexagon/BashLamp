#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo -e "\e[91mPlease run this script with superuser privileges\e[39m"
  exit
fi