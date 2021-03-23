#!/usr/bin/env bash

# Forked from Aaron's dotfiles: https://github.com/aaronbates/dotfiles
# Customized by CPannwitz: https://github.com/cpannwitz/dotfiles
# ======================================
# Idempotent setup script for dotfiles:

# Prep
# 1. Backup
# 2. Directories
# 3. Homebrew
# 4. ZSH
# 5. Node
# 6. Symlinks
# 7. Misc.

debug=${1:-false} # default debug param.
source ./setup/lib.sh # load help lib.

# ----
# Prep
# ----

defaultdotfilesdir="$HOME/dotfiles"
dotfilesdir=$(pwd)

warn "Ensure your mac system is fully up-to-date and only"
warn "run this script in terminal.app (NOT in iTerm)"
warn "=> CTRL+C now to abort or ENTER to continue."
tput bel
read -n 1

# Introduction
awesome_header

botintro "This script sets up new machines, use with caution. For more information, please see [https://github.com/cpannwitz/dotfiles]."
echo -e "\nPress ENTER to continue."
read -n 1

bot "OK, what we're going to do:\n"

actioninfo "1. Backup directories and files we'll be touching."
actioninfo "2. Create required directories."
actioninfo "3. Install Xcode Command Line Tools."
actioninfo "4. Install Homebrew and all required apps."
actioninfo "5. Create symlinks for directories and files."
actioninfo "6. Final touches."

botintro "To start we'll need your password.\n"

tput bel

ask_for_confirmation "Ready?";
if answer_is_yes; then
  ok "Let's go."
else
  cancelled "Exit."
  exit -1;
fi;

# Ask for the administrator password upfront.
ask_for_sudo

# Generate new SSH-Key
action "Generating new SSH-Key:\n"
ssh-keygen -t rsa

# Source directories and files to handle.
source ./setup/files.sh

# Install all available macos updates.
action "Installing Mac updates:\n"
sudo softwareupdate -ia

# ---------
# 1. Backup
# ---------
botintro "STEP 1: BACKUP"
source ./setup/backup.sh

# --------------
# 2. Directories
# --------------
botintro "STEP 2: DIRECTORIES"
source ./setup/directories.sh

# -----------
# 3. Homebrew
# -----------
botintro "STEP 3: HOMEBREW"
source ./setup/brew.sh

# brew is required to continue, exit out otherwise.
if ! $brewinstall;  then
  cancelled "Cannot proceed. Exit."
  exit -1
fi;

# -----------
# 4. ZSH
# -----------
botintro "STEP 4: SYMLINKS"
source ./setup/zsh.sh

# -----------
# 5. Node
# -----------
botintro "STEP 5: NODE"
source ./setup/node.sh

# -----------
# 6. Python
# -----------
botintro "STEP 6: PYTHON"
source ./setup/python.sh

# -----------
# 7. Symlinks
# -----------
botintro "STEP 7: SYMLINKS"
source ./setup/symlinks.sh

# --------
# 8. Fonts
# --------
botintro "STEP 8: Fonts"
source ./setup/fonts.sh

# --------
# 9. MacOS Settings
# --------
botintro "STEP 9: MacOS Settings"
source ./setup/macos.sh

# --------
# 10. Misc
# --------
botintro "STEP 10: Final touches"
source ./setup/misc.sh

# Wrap-up.

botintro "FINISHED --"
# EOF