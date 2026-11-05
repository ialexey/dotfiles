setopt APPEND_HISTORY
setopt SHARE_HISTORY

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR="nvim"

export PATH="$HOME/bin:$PATH"

export LESS=R # colorful less

export SSH_AUTH_SOCK=/run/user/$UID/gcr/ssh

if type eza > /dev/null; then
  alias ls="eza"
else
  echo "\033[0;31meza is not installed\033[0m"
fi

alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias glg="git log"
alias ggu='git pull origin $(git branch --show-current)'
alias ggp="git push"
alias gcp="git cherry-pick"
alias gm="git merge"
alias myip="curl ipinfo.io/ip"
alias ss="sudo systemctl"
alias neovide="neovide --fork"
alias dots='stow -d ~/dotfiles -t ~ .'

alias dst='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}.NetIO"'

type xdg-open > /dev/null && alias open="xdg-open"

setopt prompt_subst
if [[ $HOST == 'archmini' ]]; then
  autoload -U colors && colors
  PROMPT='%{$fg[red]%}[$HOST]%{$reset_color%} %2~ $(git_prompt_info)»%b '
else
  PROMPT='%2~ $(git_prompt_info)»%b '
fi

autoload -U compinit && compinit
# highlight complete item on tab
zstyle ':completion:*' menu select

autoload edit-command-line; zle -N edit-command-line

bindkey -M vicmd '_' beginning-of-line
bindkey -M vicmd v edit-command-line
bindkey '^R' history-incremental-search-backward
bindkey '^A' history-incremental-search-forward

paste-clipboard() { LBUFFER+=$(xclip -o -selection clipboard) }
zle -N paste-clipboard
bindkey '^V' paste-clipboard

function dasherize() {
  ruby -e "puts '$1'.downcase.gsub(/[^a-zA-Z0-9]/, '-').gsub(/-+/, '-').split('-')[0..8].join('-')"
}

function gcbd() {
  gcb $(dasherize $1)
}

# type rbenv > /dev/null && eval "$(rbenv init -)"
eval "$(mise activate zsh)"
# eval "$(nodenv init -)"

# make Ctrl-O working
stty discard undef

source $HOME/.claude
