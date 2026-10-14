#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# Update ZSH / OhMyZsh
# ---------------------------------------------------------------------------
echo "==> Update ZSH / OhMyZsh"
omz update

# ---------------------------------------------------------------------------
# Update, Upgrade and Cleanup Homebrew
# ---------------------------------------------------------------------------
echo "==> Update, Upgrade and Cleanup Homebrew"
# Update the formulaes and Homebrew itself:
brew update
# HOMEBREW CASKS
brew upgrade --cask --greedy
# Upgrade all formulaes:
brew upgrade --greedy-auto-updates
# Uninstall unused old versions of formulaes:
brew cleanup --prune=all

# ---------------------------------------------------------------------------
# Install / Update NVM Node Versions
# ---------------------------------------------------------------------------
echo "==> Install / Update NVM Node Versions"

# We need NVM loading:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Install Node 22 version.
nvm install 22 --skip-default-packages --latest-npm

# Install Node 24 version.
nvm install 24 --skip-default-packages --latest-npm

# Install Node 26 version.
nvm install 26 --skip-default-packages --latest-npm

nvm alias default 26
nvm use 26

# Versions we want to KEEP installed.
KEEP_VERSIONS=("22" "24" "26")

# ---------------------------------------------------------------------------
# Cleanup NVM Node Versions
# ---------------------------------------------------------------------------
echo "==> Cleanup NVM Node Versions"

# Get all installed versions (e.g. "v18.20.4", "v20.11.0", "system", etc.)
INSTALLED_VERSIONS=$(nvm ls --no-colors --no-alias | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | sort -u)

for version in $INSTALLED_VERSIONS; do
  # Extract major version (strip leading 'v', then cut at first dot)
  major="${version#v}"
  major="${major%%.*}"

  # Skip if it matches one of the versions we want to keep.
  keep=false
  for keep_major in "${KEEP_VERSIONS[@]}"; do
    if [ "$major" = "$keep_major" ]; then
      keep=true
      break
    fi
  done

  if [ "$keep" = false ]; then
    echo "    Uninstalling Node $version (major $major)..."
    nvm uninstall "$version" || echo "    Could not uninstall $version (maybe in use?)"
  else
    echo "    Keeping Node $version (major $major)"
  fi
done

nvm cache clear

# ---------------------------------------------------------------------------
# Install default global NPM Packages
# ---------------------------------------------------------------------------
echo "==> Install default global NPM Packages"
packages=(
  eslint
  npm
  prettier
  typescript
  corepack
  pnpm
)

# Installing some default global npm packages
for package in ${packages[@]}; do
  npm install --global $package
done

# ---------------------------------------------------------------------------
# Update all global NPM packages
# ---------------------------------------------------------------------------
echo "==> Update all global NPM packages"
npm install npm -g
npm update -g
npm cache clean --force
npm cache verify

# ---------------------------------------------------------------------------
# Update Apple Store (via brew/mas)
# ---------------------------------------------------------------------------
echo "==> Update Apple Store (via brew/mas)"
mas upgrade
