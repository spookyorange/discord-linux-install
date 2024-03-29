#!/bin/bash

# this is the place where we get version
echo "Getting version..."

curl -s -i -o haha https://discord.com/api/download?platform=linux&format=tar.gz

# we sleep for 3 seconds so the file can be created
sleep 3

# if the file is not created, we exit
if [ ! -f haha ]; then
    echo "Make sure you have internet connection and try again."
    echo "If you have internet connection, please report this issue on GitHub."
    exit 1
fi

contents=`cat haha`
deb_name_from_contents=`echo $contents | grep -Po 'discord-\d+\.\d+\.\d+\.deb'`
full_name=`echo $deb_name_from_contents | cut -d '-' -f 2`
just_version=`echo $full_name | cut -d '.' -f 1-3`

echo "Current version: $just_version"

rm haha

version=$just_version

link=https://dl.discordapp.net/apps/linux/$version/discord-$version.tar.gz
file=discord-$version.tar.gz
dir=Discord

echo "Installing Discord..."
echo "System might ask for your password..."
echo "It is needed to install Discord on your system, because it downloads it in your /opt folder."
echo "Version: $version"

# Delete from opt and usr if Discord is already installed
if [ -d "/usr/bin/Discord" ]; then
    echo "Discord is already installed. Removing..."
    sudo rm -rf /usr/bin/Discord
fi

if [ -d "/usr/share/discord/Discord" ]; then
    echo "Discord is already installed. Removing..."
    sudo rm -rf /usr/share/discord/Discord
fi

if [ -d "/opt/Discord" ]; then
    echo "Discord is already installed. Removing..."
    sudo rm -rf /opt/Discord
fi


# Download Discord
echo "Downloading Discord..."
curl -L $link -o $file

# Extract Discord

echo "Extracting Discord..."
tar -xvf $file

# Change the code of the desktop so it will see the icon
echo "Changing the code of the desktop so it will see the icon..."
sed -i 's/Icon=discord/Icon=\/opt\/Discord\/discord.png/g' $dir/discord.desktop

# Install Discord
echo "Installing Discord..."
echo "Moving Discord to /opt..., this might ask for your root password"
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

echo "Discord is now installed on your system, if it does not show up on the menu, restart your DE or log out and log back in."

sleep 3

echo "Have fun!"

sleep 2

exit 0
