#!/bin/bash

version=0.0.27

link=https://dl.discordapp.net/apps/linux/$version/discord-$version.tar.gz
file=discord-$version.tar.gz
dir=Discord

# Delete from opt and usr if Discord is already installed
if [ -d "/usr/bin/Discord" ]; then
    echo "Discord is already installed. Removing..."
    rm -rf /usr/bin/Discord
fi

if [ -d "/usr/share/discord/Discord" ]; then
    echo "Discord is already installed. Removing..."
    rm -rf /usr/share/discord/Discord
fi

if [ -d "/opt/Discord" ]; then
    echo "Discord is already installed. Removing..."
    rm -rf /opt/Discord
fi


# Download Discord
echo "Downloading Discord..."
curl -L $link -o $file

# Extract Discord

echo "Extracting Discord..."
tar -xvf $file

# Install Discord

echo "Installing Discord..."
sudo cp -r Discord /opt/Discord

# Create desktop entry
echo "Creating desktop entry..."
sudo cp -r /opt/Discord/discord.desktop /usr/share/applications

# Create symbolic link
echo "Creating symbolic link..."
# if discord directory doesn't exist, create it
if [ ! -d "/usr/share/discord" ]; then
    sudo mkdir /usr/share/discord
fi
sudo ln -sf /opt/Discord/Discord /usr/share/discord/Discord

# create symbolic link for users directory
echo "Creating symbolic link for users directory..."
sudo ln -sf /opt/Discord /usr/bin/Discord

# Cleanup

echo "Cleaning up..."
rm -rf $file
rm -rf $dir

echo "Done!"

exit 0