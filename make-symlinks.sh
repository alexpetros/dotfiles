#!/bin/bash
# create-symlinks.sh
#
# Create symlinks from expeted dotfile locations to this repo
# This should only be run by the Makefile, from the repository root

# Variables
repo_dir=$(pwd)
ln_flags='-svh'

# Crate symlinks (will fail if file exists)
ln $ln_flags $repo_dir/vim/vimrc ~/.vimrc
ln $ln_flags $repo_dir/vim/after ~/.vim/after
ln $ln_flags $repo_dir/tmux/tmux.conf ~/.tmux.conf
ln $ln_flags $repo_dir/zsh/zshrc ~/.zshrc
ln $ln_flags $repo_dir/zsh/zprofile ~/.zprofile
ln $ln_flags $repo_dir/latex/latexmkrc ~/.latexmkrc

# Create empty local zshrc if one doesn't exist
touch $HOME/.zshrc.local

# Install vim-plug
if [[ -f "$HOME/.vim/autoload/plug.vim" ]]; then
  echo "vim-plug already installed"
else
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install tpm
if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "tmux plugin manager already installed"
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo 'make-symlinks executed succesfully'
exit 0
