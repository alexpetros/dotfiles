# Makefile to symlink dotfiles
#
# Author: Alex Petros

# Run this script for the basic setup, minus identity-related stuff
.PHONY: all
all:
	$(CURDIR)/setup.sh

# Run this target if I want to use the machine as "Alex Petros" for git, etc.
.PHONY: alex
alex:
	$(CURDIR)/setup-identity.sh

.PHONY: server
server:
	$(CURDIR)/setup-server.sh

