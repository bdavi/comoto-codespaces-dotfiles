################################################################################
# Git Prompt
################################################################################
# Based on:
# - https://github.com/jcgoble3/gitstuff/blob/master/gitprompt.sh
# - https://gist.github.com/henrik/31631
# - https://gist.github.com/srguiwiz/de87bf6355717f0eede5

git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    local branch=$(git_branch)
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02"  # last bit resets color
    fi
}


################################################################################
# Set up my preferred prompt
################################################################################
export PS1="\e[0;32m\u@\h\e[m \e[0;36m \w\e[m  \$(git_prompt)\n$"


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
alias source!='source ~/.bashrc; tmux source-file ~/.tmux.conf; tmux display-message "SOURCED!"'
alias vc='vim -p ~/.vimrc ~/.commonrc ~/.tmux.conf ~/.zshrc ~/.bashrc'


###############################################################################
# Editor
###############################################################################
export EDITOR='vim'
alias cim='vim'
alias bim='vim'


###############################################################################
# Misc
###############################################################################
# Swap esc and caplock
alias swapesc='/usr/bin/setxkbmap -option caps:swapescape'
/usr/bin/setxkbmap -option caps:swapescape

# Keyboard speed
alias keyfast='xset r rate 225 60'
xset r rate 225 60


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
alias gdb='git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d'


# Switch to -D for danger mode
function full-prune() {
  git fetch -p
  git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}


###############################################################################
# Docker
###############################################################################
alias dc='docker compose'
