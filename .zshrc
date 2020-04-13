export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$HOME/Library/Android/sdk/emulator:$PATH"
export PATH="$HOME/Library/Android/sdk/tools/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

export PATH="/Applications/MacVim.app/Contents/bin:$PATH"
export EDITOR="mvim"

# Java shit
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.gradle/wrapper/dists/gradle-4.10.3-all/81msde2dx9p4vji0mjgtvxkcb/gradle-4.10.3/bin:$PATH"

export PATH="$HOME/bin:$PATH"

alias ls="ls -G" # with colours

alias gst="git status"

setopt prompt_subst
PROMPT='%2~ $(git_prompt_info)»%b '

function dasherize() {
  ruby -e "puts '$1'.downcase.gsub(/[^a-zA-Z0-9]/, '-').gsub(/-+/, '-').split('-')[0..8].join('-')"
}

function gcbd() {
  gcb $(dasherize $1)
}

function myip() {
  curl ipinfo.io/ip
}

bindkey -M vicmd '_' beginning-of-line

# eval "$(rbenv init -)"

node_lazy_load

# make Ctrl-O working
stty discard undef
