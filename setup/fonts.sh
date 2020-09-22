#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

fonts=(
    "DankMonoItalic.otf"
    "DankMonoRegular.otf"
    "Inconsolata-ligatures.otf"
  )

  for font in ${fonts[@]}; do
    cp -vf ~/dotfiles/fonts/$font ~/Library/Fonts
  done