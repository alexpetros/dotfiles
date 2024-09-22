#!/bin/bash
#
# Create symlinks from expeted dotfile locations to this repo
# This should only be run by the Makefile, from the repository root

# Variables
repo_dir=$(pwd)
ln_flags='-svn'
mkdir -p ~/.config/nvim

rm ~/.gitignore
rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.zshenv
rm ~/.zshrc
rm ~/.zshrc.local

rm -rf ~/.vim
rm -rf ~/.tmux

echo 'config files cleaned up'
exit 0
