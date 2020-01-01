#!/bin/bash
# create-symlinks.sh
# 
# Create symlinks from expeted dotfile locations to this repo
# This should only be run by the Makefile, from the repository root

# Variables
repo_dir=$(pwd)
ln_flags='-sv'

# Crate symlinks (will fail if file exists)
ln $ln_flags $repo_dir/vim/vimrc ~/.vimrc
ln $ln_flags $repo_dir/tmux/tmux.conf ~/.tmux.conf
ln $ln_flags $repo_dir/zsh/zshrc ~/.zshrc
ln $ln_flags $repo_dir/latex/latexmkrc ~/.latexmkrc

echo 'make-symlinks executed succesfully'
exit 0
