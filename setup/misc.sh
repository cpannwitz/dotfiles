#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

action "Setting up .nanorc"
# Install better nanorc config.
# https://github.com/scopatz/nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

action "Setting chmod for ~/.ssh"
chmod 700 "$HOME/.ssh"
print_result $? "Set chmod 700 on ~/.ssh"

# Install Theme for iTerm2
action "Installing Theme for iTerm2"
open "${dotfilesdir}/iterm2/catppuccin-macchiato.itermcolors"
open "${dotfilesdir}/iterm2/palenight.itermcolors"
open "${dotfilesdir}/iterm2/nightowl.itermcolors"
open "${dotfilesdir}/iterm2/nightowl-light.itermcolors"
open "${dotfilesdir}/iterm2/tokyo-night.itermcolors"

success "Final touches in place."
