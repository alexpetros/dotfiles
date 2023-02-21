# awp dotfiles
This is my dotfile repo!

Primarily contains editor and environment configs, as well as setup scripts for common server
configs.

## Setup
Run `make` in the source root directory for the full setup.
The installation script is "safe," so if you have an existing config, it will simply inform you that one already exists and leave it untouched.

Run `make alex` for additional configurations if you're trying to setup a development machine as me.
Right now that just means extra git config info.

## Ubuntu setup

I use the ubuntu script to setup new node server droplets by logging in as root and running the
following command:

```
curl https://raw.githubusercontent.com/alexpetros/dotfiles/main/server/ubuntu-server-setup.sh | sh
```

## TODO
* Prettify Vim config
* Breakdown ZSH into components
    * Designated slot for local configs
    * OSX and Linux-specific paths
* Scripts
    * Option on script to nuke existing configs, if they exist
    * Make backups before installing

## Inspiration
* https://github.com/holman/dotfiles
