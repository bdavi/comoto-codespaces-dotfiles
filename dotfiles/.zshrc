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


################################################################################
# Apps
################################################################################
export COMOTO_PROJECT_ROOT=/workspaces

if [ -f "$COMOTO_PROJECT_ROOT/monorepo/zlaverse/support/bash_functions.sh" ]
then
  source $COMOTO_PROJECT_ROOT/monorepo/zlaverse/support/bash_functions.sh
  alias ecom-log='docker logs -f --tail 1000 zla-ecom-webapp-1'
  alias ecom-logs='docker logs -f --tail 1000 zla-ecom-webapp-1'
  alias cg-log='container-log cycle-gear-redline-webapp'
  alias cg-logs='container-log cycle-gear-redline-webapp'
  alias rz-log='container-log revzilla-redline-webapp'
  alias rz-logs='container-log revzilla-redline-webapp'
  alias jp-log='container-log jp-cycles-redline-webapp'
  alias jp-logs='container-log jp-cycles-redline-webapp'
  alias p-log='container-log product-service'
  alias p-logs='container-log product-service'
  alias ps-log='container-log product-search-service'
  alias ps-logs='container-log product-search-service'
  alias elts='ecom-load-test-schema'
  alias cglts='cg-load-test-schema'
  alias fixit='cd $COMOTO_PROJECT_ROOT/monorepo && docker compose down && docker volume remove zla_cg-deps zla_jp-deps zla_rz-deps zla_cg-build zla_jp-build zla_rz-build && docker compose pull && docker compose up -d'
fi

if [ -f "$COMOTO_PROJECT_ROOT/ecom_api/scripts/bash_functions.sh" ]
then
  source $COMOTO_PROJECT_ROOT/ecom_api/scripts/bash_functions.sh
fi

if [ -f "$COMOTO_PROJECT_ROOT/ecom_api/scripts/bash_functions.sh" ]
then
  source $COMOTO_PROJECT_ROOT/ecom_api/scripts/bash_functions.sh
fi

################################################################################
# Google Cloud
################################################################################
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

function gca () {
    gcloud auth print-access-token | xclip -sel clip; echo "copied to clipboard"
}


################################################################################
# Prompt
################################################################################
source ~/.zsh/git-prompt.zsh/git-prompt.zsh
