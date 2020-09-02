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
brew cask upgrade --greedy

# NVM
nvm install node --latest-npm --reinstall-packages-from=node
nvm alias default node

# NPM
# Upgrade all global NPM packages
# WARNING: this needs to be run multiple times
# Apparently NPM doesn't really get all the outdated stuff at once
npm update -g
npm update -g
npm update -g

# Apple Store (via brew/mas)
mas upgrade

# MacOS
sudo softwareupdate -i -a --restart