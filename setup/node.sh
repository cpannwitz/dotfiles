#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Install NVM via curl script:
botintro "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
# Run the NVM initialize script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install latest Node version.
# action "Installing latest Node version"
# nvm install node
# Install Node version 16 (LTS)
action "Installing Node version 18 (LTS)"
nvm install 18

# Set default latest Node version.
# action "Setting default latest Node version"
# nvm alias default node
# Set default latest Node version.
action "Setting default Node version 18 (LTS)"
nvm alias default 18

packages=(
  eslint
  np
  npm
  prettier
  typescript
  yarn
)

# Installing some default global npm packages
action "Installing some default global npm packages"
for package in ${packages[@]}; do
  npm install --global $package
done

# Saving default package list to nvm dir (installs them on every version change)
for package in ${packages[@]}; do
  echo $package >> $NVM_DIR/default-packages
done