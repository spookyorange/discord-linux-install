#!/usr/bin/env bash

literal_name_of_installation_directory=".tarball-installations"
general_installation_directory="$HOME/$literal_name_of_installation_directory"
local_bin_path="$HOME/.local/bin"
local_application_path="$HOME/.local/share/applications"
local_icons_path="$HOME/icons"
tar_location=$(mktemp /tmp/discord.XXXXXX.tar.gz)

echo "Hello there, please select your version: 1, 2 or 3, return for recommended version."
echo "1 for Standard version(recommended) => default"
echo "2 for Canary version"
echo "3 for PTB version"

read version_selection

echo $version_selection

case $version_selection in
  '1')
    echo "Standard version selected"
    version_name_with_slash=""

    app_name=discord
    executable_name=discord
    old_executable_name=Discord
    ;;
  '2')
    echo "Canary version selected"
    version_name_with_slash="/canary"

    app_name=discord-canary
    executable_name=discord-canary
    old_executable_name=DiscordCanary
    ;;
  '3')
    echo "PTB version selected"
    version_name_with_slash="/ptb"

    app_name=discord-ptb
    executable_name=discord-ptb
    old_executable_name=DiscordPTB
    ;;
  '')
    echo "Standard version selected"
    version_name_with_slash=""

    app_name=discord
    executable_name=discord
    old_executable_name=Discord
    ;;
  *)
    echo "Please run it again and select a valid option"
    exit 1
    ;;
esac

app_installation_directory="$general_installation_directory/$app_name"
app_bin_in_local_bin="$local_bin_path/$app_name"
updater_bootstrap_bin_in_local_bin="$local_bin_path/updater_bootstrap"
desktop_in_local_applications="$local_application_path/$app_name.desktop"
app_icon_name="discord.png"
icon_path="$HOME/icons/$app_icon_name"
executable_path=$app_installation_directory/$executable_name
updater_bootstrap_path=$app_installation_directory/updater_bootstrap
postinst_sh_path_in_local_dir=$app_installation_directory/postinst.sh
old_executable_binary_path_to_maybe_delete="$local_bin_path/$old_executable_name"

link="https://discord.com/api$version_name_with_slash/download?platform=linux&format=tar.gz"
file=discord-$version.tar.gz
dir=Discord


echo "Installing Discord..."
echo "Installation target=$app_installation_directory"
sleep 1

# Delete from opt and usr if Discord is already installed
if [ -f $app_bin_in_local_bin ]; then
  echo "Old bin file detected, removing..."
  rm $app_bin_in_local_bin
fi

if [ -f $updater_bootstrap_bin_in_local_bin ]; then
  echo "Old updater bootstrap bin file detected, removing..."
  rm $updater_bootstrap_bin_in_local_bin
fi


if [ -d $app_installation_directory ]; then
  echo "Old app files are found, removing..."
  rm -rf $app_installation_directory
fi

if [ -f $desktop_in_local_applications ]; then
  echo "Old bin file detected, removing..."
  rm $desktop_in_local_applications
fi

if [ -f $old_executable_binary_path_to_maybe_delete ]; then
  echo "Old bin from older installation detected, removing..."
  rm $old_executable_binary_path_to_maybe_delete
fi

if [ ! -d $general_installation_directory ]; then
  echo "Creating the $general_installation_directory directory for installation"
  mkdir $general_installation_directory
fi

if [ ! -d $local_bin_path ]; then
  echo "$local_bin_path not found, creating it for you"
  mkdir $local_bin_path
fi

if [ ! -d $local_icons_path ]; then
  echo "$local_icons_path not found, creating it for you"
  mkdir $local_icons_path
fi

if [ ! -d $local_application_path ]; then
  echo "$local_application_path not found, creating it for you"
  mkdir $local_application_path
fi

# Download Discord
echo "Downloading Discord..."
curl -L $link -o $tar_location
if [ $? -eq 0 ]; then
    echo OK
else
    echo "Installation failed. Curl not found or not installed"
    exit
fi

# Extract Discord
echo "Extraction in process.."

mkdir $app_name
tar -xvf $tar_location -C $app_name --strip-components=1

current_desktop_path="$app_name/$app_name.desktop"

# Change the code of the desktop so it will see the icon
echo "Adjusting desktop file to tailor your needs..."
sed -i "s|Exec=/usr/bin/$executable_name|Exec=$app_bin_in_local_bin|g" $current_desktop_path
sed -i "s|Path=/usr/bin|Path=$local_bin_path|g" $current_desktop_path
sed -i "s|Icon=$app_name|Icon=$icon_path|g" $current_desktop_path

# Install Discord
echo "Moving files to your safe directory..."
mv $app_name $app_installation_directory

# Create desktop entry
echo "Copying a personalized desktop entry..."
cp $app_installation_directory/$app_icon_name $icon_path
cp $app_installation_directory/$app_name.desktop $desktop_in_local_applications

echo "Copying the bin files..."
cp $executable_path $app_bin_in_local_bin
cp $updater_bootstrap_path $updater_bootstrap_bin_in_local_bin

echo "------------------------------"
echo "------------------------------"
echo "------------------------------"
echo "There is a postinst.sh that was included with the package"
echo "It is not being ran by this script for it is strictly non root available"
echo "You can run the code below to easily run it yourself"
echo "sh $postinst_sh_path_in_local_dir"
echo "------------------------------"
echo "------------------------------"
echo "------------------------------"

# Cleanup
echo "Cleaning up..."
rm $tar_location
rm -rf $dir

echo "Installation is successful!"

echo "Discord is now installed on your system, if it does not show up on the menu, restart your DE or log out and log back in."

sleep 3

echo "Have fun!"

sleep 2

exit 0
