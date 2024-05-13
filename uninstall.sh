#!/usr/bin/env bash

literal_name_of_installation_directory=".tarball-installations"
general_installation_directory="$HOME/$literal_name_of_installation_directory"
local_bin_path="$HOME/.local/bin"
local_application_path="$HOME/.local/share/applications"
tar_location=$(mktemp /tmp/discord.XXXXXX.tar.gz)

echo "Hello there, please select your version: 1, 2 or 3, return for default version."
echo "1 for Standard version => default"
echo "2 for Canary version"
echo "3 for PTB version"

read version_selection

echo $version_selection

case $version_selection in
  '1')
    echo "Standard version selected"
    version_name_with_slash=""

    app_name=discord
    executable_name=Discord
    ;;
  '2')
    echo "Canary version selected"
    version_name_with_slash="/canary"

    app_name=discord-canary
    executable_name=DiscordCanary
    ;;
  '3')
    echo "PTB version selected"
    version_name_with_slash="/ptb"

    app_name=discord-ptb
    executable_name=DiscordPTB
    ;;
  '')
    echo "Standard version selected"
    version_name_with_slash=""

    app_name=discord
    executable_name=Discord
    ;;
  *)
    echo "Please run it again and select a valid option"
    exit 1
    ;;
esac

app_installation_directory="$general_installation_directory/$app_name"
app_bin_in_local_bin="$local_bin_path/$app_name"
desktop_in_local_applications="$local_application_path/$app_name.desktop"
icon_path=$app_installation_directory/discord.png
executable_path=$app_installation_directory/$executable_name

echo "Uninstalling Discord from your system..."
rm $desktop_in_local_applications
rm $app_bin_in_local_bin
rm -rf $app_installation_directory

echo "Uninstallation is complete!"

sleep 2
exit 0

