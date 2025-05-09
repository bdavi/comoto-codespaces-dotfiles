###############################################################################
# Save me from myself
###############################################################################
alias celar='clear'
alias cleawr='clear'


###############################################################################
# Shell / Tmux
###############################################################################
alias c="clear"
alias ll="ls -lah"
alias rename='tmux rename-window'
alias source!='source ~/.zshrc; tmux source-file ~/.tmux.conf; tmux display-message "SOURCED!"'
alias vc='vim -p ~/.vimrc ~/.commonrc ~/.tmux.conf ~/.zshrc ~/.zshrc'


###############################################################################
# Editor
###############################################################################
export EDITOR='vim'
alias cim='vim'
alias bim='vim'


###############################################################################
# Safety
###############################################################################
# Require confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Don't rm root and prompt for multiple files
alias rm='rm -I --preserve-root'


###############################################################################
# Git
###############################################################################
alias gl="git log --pretty=format:'%C(yellow)%h%C(reset) - %an [%C(green)%ar%C(reset)] %s' --graph"
alias gdc='git diff --cached'
alias gdm='git diff master..$(git rev-parse --abbrev-ref HEAD)'
alias ga.='git add .'
alias gst='git status'
alias gc='git commit'
alias gp='git push'
alias ga='git add'
# Delete branches already merged into current branch
alias gdb='git branch --merged | grep -E -v "(^\*|master|main|dev)" | xargs git branch -d'


# Switch to -D for danger mode
function full-prune() {
  git fetch -p
  git branch -r | awk '{print $1}' | grep -E -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}


###############################################################################
# Docker
###############################################################################
alias dc='docker compose'
