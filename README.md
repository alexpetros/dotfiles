# awp dotfiles
This is my dotfile repo!

Primarily contains editor and environment configs, as well as setup scripts for common server
configs.

## setup
Run `make` in the source root directory to create the symlinks which "install" the files. Don't try to run `make` from anywhere else, it won't work.

The installation script is "safe," so if you have an existing config, it will simply inform you that one already existis and leave it untouched.

Sublime installation is manual, for now.

## todo
* New configs
    * Add global gitignore
    * Prettify Vim config
    * Breakdown ZSH into components
        * Designated slot for local configs
        * OSX and Linux-specific paths
* Scripts
    * Option on script to nuke existing configs, if they exist
    * Make backups before installing
* Bugs
	* Running make twice creates a second "after" folder because ln works differently on dirs

## inspiration
* https://github.com/holman/dotfiles
