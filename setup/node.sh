#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# TODO: replace NVM with https://github.com/jdx/mise

# Install NVM via curl script:
botintro "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Run the NVM initialize script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Node 20 version.
action "Installing Node 20 Version (LTS)"
nvm install 20 --skip-default-packages --latest-npm

# Install Node 20 version.
action "Installing Node 22 Version (LTS)"
nvm install 22 --skip-default-packages --latest-npm

# Set default latest Node version.
action "Setting Node 20 Version as Default"
nvm alias default 22
nvm use 22

packages=(
  npm
  eslint
  prettier
  typescript
  corepack
  yarn
  pnpm
)

# Installing some default global npm packages
action "Installing some default global npm packages"
for package in ${packages[@]}; do
  npm install --global $package
done

# NPM
# Upgrade all global NPM packages
npm install npm -g
npm update -g
npm cache verify

# Saving default package list to nvm dir (installs them on every version change)
for package in ${packages[@]}; do
  echo $package >> $NVM_DIR/default-packages
done
