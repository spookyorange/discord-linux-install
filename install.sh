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

app_name=discord
literal_name_of_installation_directory=".tarball-installations"
general_installation_directory="$HOME/$literal_name_of_installation_directory"
app_installation_directory="$general_installation_directory/discord"
local_bin_path="$HOME/.local/bin"
local_application_path="$HOME/.local/share/applications"
app_bin_in_local_bin="$local_bin_path/$app_name"
desktop_in_local_applications="$local_application_path/$app_name.desktop"
icon_path=$app_installation_directory/discord.png
executable_path=$app_installation_directory/Discord


echo "Installing Discord..."
echo "Installation target=$app_installation_directory"
sleep 1
echo "Version: $version"
sleep 1

# Delete from opt and usr if Discord is already installed
if [ -f $app_bin_in_local_bin ]; then
  echo "Old bin file detected, removing..."
  rm $app_bin_in_local_bin
fi

if [ -d $app_installation_directory ]; then
  echo "Old app files are found, removing..."
  rm -rf $app_installation_directory
fi

if [ -f $desktop_in_local_applications ]; then
  echo "Old bin file detected, removing..."
  rm $desktop_in_local_applications
fi

if [ ! -d $general_installation_directory ]; then
  echo "Creating the $general_installation_directory directory for installation"
  mkdir $general_installation_directory
fi

if [ ! -d $local_bin_path ]; then
  echo "$local_bin_path not found, creating it for you"
  mkdir $local_bin_path
fi

if [ ! -d $local_application_path]; then
  echo "$local_application_path not found, creating it for you"
  mkdir $local_application_path
fi

# Download Discord
echo "Downloading Discord..."
curl -L $link -o $file
if [ $? -eq 0 ]; then
    echo OK
else
    echo "Installation failed. Curl not found or not installed"
    exit
fi

# Extract Discord
echo "Extraction in process.."
tar -xvf $file

# Change the code of the desktop so it will see the icon
echo "Adjusting desktop file to tailor your needs..."
sed -i "s|Icon=discord|Icon=$icon_path|g" $dir/discord.desktop
sed -i "s|Exec=/usr/share/discord/Discord|Exec=$executable_path|g" $dir/discord.desktop

# Install Discord
echo "Moving files to your safe directory..."
mv Discord $app_installation_directory

# Create desktop entry
echo "Copying a personalized desktop entry..."
cp $app_installation_directory/discord.desktop $desktop_in_local_applications

# Create symbolic link
echo "Creating a bin file for the current user..."
touch $app_bin_in_local_bin
chmod u+x $app_bin_in_local_bin
echo "#!/bin/bash
$executable_path" >> $app_bin_in_local_bin

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
