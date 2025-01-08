# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to Golang installation
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

export NODE_OPTIONS=--max-old-space-size=8192

source ~/workspace/workenv.sh

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
plugins=(bgnotify z zsh-nvm zsh-autosuggestions zsh-syntax-highlighting zsh-npm-scripts-autocomplete fzf-tab)

# See: https://github.com/zsh-users/zsh-completions/issues/603
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

##########
# ALIASES
##########
alias updatesystem="$HOME/dotfiles/update.sh"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd $HOME" # `cd` is probably faster to type though
alias -- -="cd -"

alias dls="cd $HOME/Downloads"
alias dotfiles="cd $HOME/dotfiles"
alias desk="cd $HOME/Desktop"
alias lib="cd $HOME/Library"
alias work="cd $HOME/workspace"
alias priv="cd $HOME/privatespace"

alias g="git"

# mv, rm, cp, etc
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'

alias ls="eza -l --icons=always --hyperlink --git" # all files
alias ll="eza -la --icons=always --hyperlink --git" # all files including dotfiles
alias ld="eza -lD --icons=always --hyperlink --git" # only directories

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# npm
alias ni="npm install"
alias npmg="npm list -g --depth=0 2>/dev/null"
alias npml="npm list --depth=0 2>/dev/null"
alias npmog="npm outdated -g --depth=0"
alias npmug="npm update -g"
alias npmol="npm outdated --depth=0"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"


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

# see why we source this: https://github.com/zsh-users/zsh-syntax-highlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# initialize powerlevel10k zsh theme
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

source <(fzf --zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
