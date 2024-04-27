# Want to Install Discord but can't or won't use your package manager, flatpak, snap etc.?

Well, you may just install it using a tarball, no one is stopping you! This script will make it a breeze, usage consists of 3 lines of code for you to execute. Also it has no "sudo" in it, so you may install it without root privileges!


This script supports majority of Linux distros which includes but not limited to: Fedora, Fedora Atomic(Silverblue)

## Usage

To use it, just clone the repo and run the script!

```bash

git clone https://github.com/spookyorange/discord-linux-install.git
cd discord-linux-install
sh ./install.sh

```

To remove it, run the remove script

```bash

sh ./uninstall.sh

```

Updates are handled by running the install script again, you can just run the install script and all good!

```bash

sh ./install.sh

```

## Details

This script will install Discord in the following locations:

- $HOME/.tarball-installations/discord
- $HOME/.local/bin/discord
- $HOME/.local/share/applications/discord.desktop

It will also create a desktop entry for Discord, so you can launch it from your desktop environment's application launcher.

## Migration

Just run the migrate script, and the app will now move to local location for your user!

```bash

sh ./migrate.sh

```

### Tested Distros

- Fedora by Spookyorange
- Atomic Fedora(Silverblue) by Spookyorange

### Contributing

If you have a distro that you would like to add to the list of tested distros, please submit a pull request with the changes you made to the script and the distro you tested it on.

If the version of Discord changes, please submit a pull request with the changes you made to the script and the version of Discord you tested it with. Or if you don't know what to change, open an issue.
