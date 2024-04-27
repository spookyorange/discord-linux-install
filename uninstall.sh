#!/bin.bash

literal_name_of_installation_directory=".tarball-installations"
general_installation_directory="$HOME/$literal_name_of_installation_directory"
bin_file_location="$HOME/.local/bin/discord"
desktop_file_location="$HOME/.local/share/applications/discord.desktop"
discord_installation_directory="$general_installation_directory/discord"

echo "Uninstalling Discord from your system..."
rm $desktop_file_location
rm $bin_file_location
rm -rf $discord_installation_directory

echo "Uninstallation is complete!"

sleep 2
exit 0
