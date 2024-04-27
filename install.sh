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


literal_name_of_installation_directory=".tarball-installations"
general_installation_directory="$HOME/$literal_name_of_installation_directory"
bin_file_location="$HOME/.local/bin/discord"
desktop_file_location="$HOME/.local/share/applications/discord.desktop"
discord_installation_directory="$general_installation_directory/discord"

echo "Installing Discord..."
echo "Installation target=$discord_installation_directory"
sleep 1
echo "Version: $version"
sleep 1

# Delete from opt and usr if Discord is already installed
if [ -d $bin_file_location ]; then
  echo "Old bin file detected, removing..."
  rm $bin_file_location
fi

if [ -d $discord_installation_directory ]; then
  echo "Old app files are found, removing..."
  rm -rf $discord_installation_directory
fi

if [ ! -d $general_installation_directory ]; then
  echo "Creating the $general_installation_directory directory for installation"
  mkdir $general_installation_directory
fi

if [ ! -d $HOME/.local/bin/ ]; then
  echo "$HOME/.local/bin not found, creating it for you"
  mkdir $HOME/.local/bin/
fi

# Download Discord
echo "Downloading Discord..."
curl -L $link -o $file

# Extract Discord
echo "Extraction in process.."
tar -xvf $file

# Change the code of the desktop so it will see the icon
echo "Adjusting desktop file to tailor your needs..."
sed -i "s|Icon=discord|Icon=$discord_installation_directory/discord.png|g" $dir/discord.desktop
sed -i "s|Exec=/usr/share/discord/Discord|Exec=discord|g" $dir/discord.desktop

# Install Discord
echo "Moving files to your safe directory..."
mv Discord $discord_installation_directory

# Create desktop entry
echo "Copying a personalized desktop entry..."
cp $discord_installation_directory/discord.desktop $desktop_file_location

# Create symbolic link
echo "Creating a bin file for the current user..."
touch $bin_file_location
chmod u+x $bin_file_location
echo "#!/bin/bash
$discord_installation_directory/Discord" >> $bin_file_location

# Cleanup
echo "Cleaning up..."
rm -rf $file
rm -rf $dir

echo "Installation is successful!"

echo "Discord is now installed on your system, if it does not show up on the menu, restart your DE or log out and log back in."

sleep 3

echo "Have fun!"

sleep 2

exit 0
