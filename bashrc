#!/bin/bash
#
# Adrien Delorme's bash environment
# Much taken from Ryan Tomayko (thanks!)

# Basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# Complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

#-------------------------------------------------------------------------------
# SHELL stuff
#-------------------------------------------------------------------------------

# Ignore backups, CVS directories
FIGNORE="~:CVS:#:.pyc"
HISTCONTROL=ignoreboth



#-------------------------------------------------------------------------------
# Aliases / Functions
#-------------------------------------------------------------------------------
alias dul='du -h --max-depth=1'
alias hi='history | tail -20'

# Git aliases
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gdiff='git diff'
alias gl='git prettylog'
alias gp='git push'
alias gs='git status'
alias gt='git tag'

# Others
alias be='bundle exec'
alias v='vagrant'






# Setup TTY for GPG
export GPG_TTY=$(tty)
