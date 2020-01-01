#!/bin/bash
# make-symlinks.sh
# 
# Create symlinks from expeted dotfile locations to this repo
# This should only be run by the Makefile, from the repository root

# Variables
repo_dir=$(pwd)

# Crate symlinks (will fail if file exists)
ln -s $repo_dir/vim/vimrc ~/.vimrc
ln -s $repo_dir/tmux/tmux.conf ~/.tmux.conf
ln -s $repo_dir/zsh/zshrc ~/.zshrc
ln -s $repo_dir/latex/latexmkrc ~/.latexmkrc

echo 'make-symlinks executed succesfully'
exit 0
