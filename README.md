# Want to Install Discord but don't use Debian or Ubuntu?

## Well, have I got a solution for you!

### This is a script that will install Discord on most Linux distros!

To use it, just clone the repo and run the script!

```bash

git clone git@github.com:spookyorange/discord-linux-install.git
cd discord-linux-install
./install.sh

```

To remove it, run the remove script

```bash

./remove.sh

```

Updates are not handled automatically for now, you can pull the latest version of the script and run it again to update Discord.

```bash

git pull
./install.sh

```

### Details

This script will install Discord in the following locations:

- /opt/Discord
- /usr/share/applications/discord.desktop
- /usr/bin/discord

It will also create a desktop entry for Discord, so you can launch it from your desktop environment's application launcher.

### Tested Distros

- Fedora by Spookyorange

### Contributing

If you have a distro that you would like to add to the list of tested distros, please submit a pull request with the changes you made to the script and the distro you tested it on.

If the version of Discord changes, please submit a pull request with the changes you made to the script and the version of Discord you tested it with. Or if you don't know what to change, open an issue.
