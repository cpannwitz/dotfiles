# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to flutter configuration
export PATH="$PATH:$HOME/flutter/bin"
# Path to CocoaPods
export PATH=$HOME/.gem/bin:$PATH

# Path to Golang installation
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Path to Temurin / OpenJDK / Java
# NOTE: version 20 required by React Native | if not needed, omit "-v 20"
export JAVA_HOME=$(/usr/libexec/java_home -v 20)
export PATH="$PATH:${JAVA_HOME}"

# Path to Android Studio, SDK, Emulator
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

source ~/workspace/workenv.sh

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# Use Brew Ruby instead of MacOS Ruby
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi




# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1


# ZSH-NVM settings
# https://github.com/lukechilds/zsh-nvm
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bgnotify z zsh-nvm zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


### Fix slowness of pastes with zsh-syntax-highlighting.zsh
DISABLE_MAGIC_FUNCTIONS=true
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# https://twitter.com/wesbos/status/601426471240998912
function t() {
 tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -aC $2
}

# iterm2 Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# NVM node manager integration
# ! WARNING ! PERFORMANCE DEGRADING OPTION !
# ! WARNING ! Doesn't seem to be useful, when zsh-nvm is used ? !
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# see why we source this: https://github.com/zsh-users/zsh-syntax-highlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize pyenv, see: https://github.com/pyenv/pyenv
# ! WARNING ! PERFORMANCE DEGRADING OPTION !
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# export PATH="$HOME/.poetry/bin:$PATH"

eval "$(starship init zsh)"