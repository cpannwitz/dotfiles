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
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    print_result $? 'Install Homebrew.'

    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/cpannwitz/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/cpannwitz/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
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

  # zsh
  brew install zsh
  brew install zsh-completion
  brew install zsh-autosuggestions

  # Install `wget`
  brew install wget
  brew install nano
  brew install openssh

  # OTHER USEFUL UTILS
  brew install brew-cask-completion
  brew install terminal-notifier
  brew install wifi-password
  brew install mas # package manager
  brew install jq # JSON formatter (... | jq)

  # GITHUB CLI
  brew install gh

  # DATABASES
  brew install postgresql
  brew tap mongodb/brew
  brew install mongodb-community
  brew install mysql
  brew install redis

  # DEV
  brew install watchman
  brew install cocoapods
  brew install hadolint # Docker linter
  brew install httpie

  # Golang
  brew install go
  brew install golangci-lint
  # global Golang packages:
  # go install github.com/swaggo/swag/cmd/swag@latest
  # go install github.com/swaggo/swag/cmd/swag@1.8.7
  # go install github.com/securego/gosec/v2/cmd/gosec@latest

  # FONTS
  running "Installing fonts"

  # MUST HAVE STEP to install fonts!
  brew tap homebrew/cask-fonts

  brew install --cask font-fira-code
  brew install --cask font-fira-sans
  brew install --cask font-fontawesome
  brew install --cask font-inconsolata
  brew install --cask font-inter
  brew install --cask font-hack
  brew install --cask font-jetbrains-mono
  brew install --cask font-lato
  brew install --cask font-open-sans
  brew install --cask font-roboto
  brew install --cask font-source-code-pro
  brew install --cask font-source-sans-pro
  brew install --cask font-ubuntu
  brew install --cask font-cascadia-code
  brew install --cask font-cascadia-code-pl
  brew install --cask font-cascadia-mono
  brew install --cask font-cascadia-mono-pl
  brew install --cask font-victor-mono

  running "Installing cask apps"

  # APPLICATIONS
  brew tap homebrew/cask-versions

  # General
  brew install --cask browserosaurus
  brew install --cask macs-fan-control
  brew install --cask boom-3d
  brew install --cask nightowl
  brew install --cask keka
  brew install --cask termius
  brew install --cask 1password
  brew install --cask 1password-cli
  brew install --cask bitwarden
  brew install --cask telegram
  brew install --cask whatsapp
  brew install --cask signal
  brew install --cask karabiner-elements
  brew install --cask alt-tab
  brew install --cask raycast
  brew install --cask appcleaner
  brew install --cask google-chrome
  brew install --cask firefox-developer-edition
  brew install --cask microsoft-edge
  brew install --cask orion
  brew install --cask iterm2
  brew install --cask slack
  brew install --cask notion
  brew install --cask obsidian
  brew install --cask spotify
  brew install --cask google-drive # disable chrome plugins to allow auth in browser

  # Design
  brew install --cask figma
  brew install --cask framer

  # Development
  brew install --cask temurin # successor to adoptopenjdk
  brew install --cask android-sdk
  brew install --cask android-studio
  brew install --cask pgadmin4
  brew install --cask robo-3t
  brew install --cask insomnia
  brew install --cask graphql-playground
  brew install --cask cyberduck
  brew install --cask gitkraken
  brew install --cask imageoptim
  brew install --cask stats
  brew install --cask visual-studio-code
  brew install --cask lens # k8s

  # Quicklook
  brew install --cask qlcolorcode
  brew install --cask qlstephen
  brew install --cask qlmarkdown
  brew install --cask quicklook-json
  brew install --cask quicklook-csv
  brew install --cask qlimagesize
  brew install --cask suspicious-package
  brew install --cask quicklookase
  brew install --cask qlvideo
  brew install --cask webpquicklook

  # Install Mac App Store Applications.
  # ! requires: brew install mas
  mas install 441258766 # Magnet
  mas install 1451685025 # Wireguard
  mas install 1528890965 # TextSniper
  mas install 1176895641 # Spark E-Mail
  mas install 966085870 # TickTick

  running "brew cleanup"
  # Remove outdated versions from the cellar.
  brew cleanup

  # turn off prevent sleep.
  killall caffeinate
fi;