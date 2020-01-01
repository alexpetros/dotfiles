# Makefile to symlink dotfiles
#
# Author: Alex Petros

.PHONY: all clean

all:
	$(CURDIR)/scripts/make-symlinks.sh
	
