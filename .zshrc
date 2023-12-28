export HISTSIZE=1000000
export SAVEHIST=1000000

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/Applications/MacVim.app/Contents/bin:$PATH"
export EDITOR="vim"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/build-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
# export JAVA_HOME="$(/usr/libexec/java_home -v 11)" # brew install temurin11

export PATH="$HOME/bin:$PATH"

export LESS=R # colorful less

alias ls="exa"

alias g="git"
alias gst="git status"
alias gco="git checkout"
alias glg="git log"
alias ggu='git pull origin $(git branch --show-current)'
alias ggp="git push"
alias gcp="git cherry-pick"
alias gm="git merge"
alias myip="curl ipinfo.io/ip"
alias nv="neovide --frame None --maximized"

alias dst='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}.NetIO"'

setopt prompt_subst
PROMPT='%2~ $(git_prompt_info)»%b '

autoload -U compinit && compinit
# highlight complete item on tab
zstyle ':completion:*' menu select

autoload edit-command-line; zle -N edit-command-line

bindkey -M vicmd '_' beginning-of-line
bindkey -M vicmd v edit-command-line
bindkey '^R' history-incremental-search-backward
bindkey '^A' history-incremental-search-forward

function dasherize() {
  ruby -e "puts '$1'.downcase.gsub(/[^a-zA-Z0-9]/, '-').gsub(/-+/, '-').split('-')[0..8].join('-')"
}

function gcbd() {
  gcb $(dasherize $1)
}

eval "$(rbenv init -)"
eval "$(nodenv init -)"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # https://github.com/rbenv/ruby-build/issues/1385

# make Ctrl-O working
stty discard undef

source ~/.config/private
source /Users/alexey/.config/op/plugins.sh
