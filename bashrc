# Path to your oh-my-bash installation.
export OSH=~/.oh-my-bash

OSH_THEME="bakke"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

alias mybash="nvim ~/.bashrc"
alias myi3="nvim ~/.i3/config"
alias nv="nvim"
alias night="xbacklight -set 1"
alias mynvim="nvim ~/dots/nvim.vim"
alias updt="sudo pacman -Syyu"
alias py="python"
alias python3='python'

