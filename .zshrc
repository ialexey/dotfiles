export HISTSIZE=1000000
export SAVEHIST=1000000

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$HOME/Library/Android/sdk/emulator:$PATH"
export PATH="$HOME/Library/Android/sdk/tools/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

export PATH="/Applications/MacVim.app/Contents/bin:$PATH"
export EDITOR="vim"

# Java shit
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.gradle/wrapper/dists/gradle-4.10.3-all/81msde2dx9p4vji0mjgtvxkcb/gradle-4.10.3/bin:$PATH"

export PATH="$HOME/bin:$PATH"

alias ls="exa"

alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gst="git status"
alias glg="git log"
alias ggu="git pull"
alias ggp="git push"
alias gcp="git cherry-pick"
alias gm="git merge"
alias myip="curl ipinfo.io/ip"

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
