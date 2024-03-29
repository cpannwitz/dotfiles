#!/usr/bin/env bash
debug=${1:-false}

# Load help lib if not already loaded.
if [ -z ${libloaded+x} ]; then
  source ./lib.sh
fi;

botintro "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# action "Installing Spaceship Prompt"
# mkdir -p ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/spaceship-prompt
# # Git cloning the repository into the ZSH themes folder
# git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/spaceship-prompt
# # Symlink spaceship.zsh-theme to your oh-my-zsh custom themes directory:
# ln -s "${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"
# # Set ZSH_THEME="spaceship" in your .zshrc (already done by preset .zshrc)

action "Configuring Starship Prompt"
starship preset nerd-font-symbols > $HOME/.config/starship.toml

action "Make iTerm2 ZSH shell integration"
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh


action "Install plugins for ZSH"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting