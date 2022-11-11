#!/bin/bash
if [ "$EUID" -ne 0 ]; then 
	print_red "Please run this script with superuser privileges"
	exit 1
fi