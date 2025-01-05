#!/usr/bin/env bash

# This script aims to update packages of several services used
# - homebrew
# - homebrew casks
# - NVM
# - NPM
# - Apple Store (via brew/mas)

# HOMEBREW
# Update the formulaes and Homebrew itself:
brew update
# HOMEBREW CASKS
brew upgrade --cask --greedy
# Upgrade all formulaes:
brew upgrade --greedy-auto-updates
# Uninstall unused old versions of formulaes:
brew cleanup --prune=all

# We need NVM loading:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Install Node 20 version.
nvm install 20 --skip-default-packages --latest-npm

# Install Node 22 version.
nvm install 22 --skip-default-packages --latest-npm

# Set default latest Node version.
nvm alias default 22
nvm use 22

packages=(
  eslint
  npm
  prettier
  typescript
  corepack
  yarn
  pnpm
)

# Installing some default global npm packages
for package in ${packages[@]}; do
  npm install --global $package
done

# NPM
# Upgrade all global NPM packages
npm install npm -g
npm update -g
npm cache clean --force
npm cache verify


# Apple Store (via brew/mas)
mas upgrade
