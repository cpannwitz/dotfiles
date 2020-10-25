#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

# Set install flag to false
brewinstall=false

bot "Install Homebrew and all required apps."

ask_for_confirmation "\nReady to install apps? (get a coffee, this takes a while)";

# Flag install to go if user approves
if answer_is_yes; then
  ok
  brewinstall=true
else
  cancelled "Homebrew and applications not installed."
fi;

if $brewinstall; then
  # Prevent sleep.
  caffeinate &

  action "Installing Homebrew"
  # Check if brew installed, install if not.
  if ! hash brew 2>/dev/null; then
    # note: if your /usr/local is locked down (like at Google), you can do this to place everything in ~/.homebrew
    # mkdir "$HOME/.homebrew" && curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
    # then add this to your path: export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    print_result $? 'Install Homebrew.'
  else
    success "Homebrew already installed."
  fi;

  running "brew update + brew upgrade"
  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade

  # CORE
  running "Installing apps"

  # Key tools.
  brew install git
  brew install svn

  # zsh
  brew install zsh
  brew install zsh-completion
  brew install zsh-autosuggestions

  # Install `wget`
  brew install wget

  # Install more recent versions of some native macOS tools.
  brew install nano
  brew install openssh

  # OTHER USEFUL UTILS
  brew install brew-cask-completion
  brew install terminal-notifier
  brew install wifi-password
  brew install mas
  brew install pyenv
  brew install pyenv-virtualenv
  brew install kubernetes-cli
  brew install gh

  # DATABASES
  brew install postgresql
  brew tap mongodb/brew
  brew install mongodb-community
  brew install mysql
  brew install redis

  # DEVOPS
  brew tap heroku/brew
  brew install heroku
  brew install watchman
  brew install cocoapods
  brew install deno

  # FONTS
  running "Installing fonts"

  brew tap homebrew/cask-fonts

  brew cask install font-fira-code
  brew cask install font-fira-sans
  brew cask install font-fontawesome
  brew cask install font-inconsolata
  brew cask install font-lato
  brew cask install font-open-sans
  brew cask install font-roboto
  brew cask install font-source-code-pro
  brew cask install font-source-sans-pro
  brew cask install font-ubuntu

  running "Installing cask apps"

  # APPLICATIONS
  brew tap homebrew/cask-versions

  # General
  brew cask install keka
  brew cask install 1password
  brew cask install telegram
  brew cask install whatsapp
  brew cask install signal
  brew cask install toggl-track
  brew cask install kap
  brew cask install spotmenu
  brew cask install pdf-expert
  brew cask install karabiner-elements
  brew cask install alfred
  brew cask install appcleaner
  brew cask install google-backup-and-sync
  brew cask install signal
  brew cask install discord
  brew cask install google-chrome
  brew cask install firefox-developer-edition
  brew cask install iterm2
  brew cask install slack
  brew cask install slite
  brew cask install notion
  brew cask install notable
  brew cask install spotify
  brew cask install skype
  brew cask install stats

  # Design
  brew cask install figma
  brew cask install framer

  # Development
  brew cask install adoptopenjdk
  brew cask install android-sdk
  brew cask install android-studio
  brew cask install tunnelblick
  brew cask install termius
  brew cask install pgadmin4
  brew cask install dbeaver-community
  brew cask install insomnia
  brew cask install insomnia-designer
  brew cask install graphql-playground
  brew cask install cyberduck
  brew cask install gitkraken
  brew cask install kitematic
  brew cask install imageoptim
  brew cask install sublime-text
  brew cask install visual-studio-code
  brew cask install visual-studio-code-insiders

  # Quicklook
  brew cask install qlcolorcode
  brew cask install qlstephen
  brew cask install qlmarkdown
  brew cask install quicklook-json
  brew cask install quicklook-csv
  brew cask install qlimagesize
  brew cask install suspicious-package
  brew cask install quicklookase
  brew cask install qlvideo
  brew cask install webpquicklook

  # Install Mac App Store Applications.
  # ! requires: brew install mas
  mas install 441258766 # Magnet
  mas install 1254981365 # Contrast
  mas install 1176895641 # Spark E-Mail
  mas install 1295203466 # MS Remote Desktop

  running "brew cleanup"
  # Remove outdated versions from the cellar.
  brew cleanup

  # turn off prevent sleep.
  killall caffeinate
fi;
