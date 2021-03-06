#!/usr/bin/env bash

# This script aims to update packages of several services used
# - homebrew
# - homebrew casks
# - NVM
# - NPM
# - Apple Store (via brew/mas)
# - MacOS

# HOMEBREW
# Update the formulaes and Homebrew itself:
brew update
# Upgrade all formulaes:
brew upgrade
# Uninstall unused old versions of formulaes:
brew cleanup

# HOMEBREW CASKS
brew upgrade --cask

# We need NVM loading:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# NVM
# # Install Node version 14 (LTS)
nvm install 14 --reinstall-packages-from=node
nvm alias default 14

# NPM
# Upgrade all global NPM packages
npm install npm -g
npm update -g
npm cache verify


# Apple Store (via brew/mas)
mas upgrade

# MacOS
sudo softwareupdate -i -a