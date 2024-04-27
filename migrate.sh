#!/bin/bash

echo "Welcome to migration for Discord installation script!"

echo "Because that the old version needed root privileges, you might be asked for your password"

echo "This script will delete Discord from old locations, then install it on your system in a local manner..."

sh remove-old.sh

echo "Older one is uninstalled, installing the new one..."

sh install.sh

echo "Operation successful"

sleep 2

exit 0
