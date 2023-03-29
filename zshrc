
# Basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# Complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PAT
fpath=(/usr/local/share/zsh-completions $fpath)

#-------------------------------------------------------------------------------
# Oh my zsh
#-------------------------------------------------------------------------------

# even the 'reminder' mode takes 50% of startup time.
zstyle ':omz:update' mode disabled

export ZSH="/Users/$USER/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(
  git
)

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------

alias k="clear;l"
alias freewifi="sudo ifconfig en0 ether `openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`"
alias rnd="cat /dev/urandom | base64 | tr -dc '0-9a-zA-Z' | head -c 10"

#-------------------------------------------------------------------------------
# Local configs, if any ?
#-------------------------------------------------------------------------------

test -r ~/.zshrc.local && source ~/.zshrc.local
test -r ~/.config/op/plugins.sh && source ~/.config/op/plugins.sh

#-------------------------------------------------------------------------------
# Check if there's a local path folder 
#-------------------------------------------------------------------------------

test -r ~/path && export PATH="$PATH:/Users/$USER/path"

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------

# System bashrc
test -r /etc/zshrc && . /etc/zshrc

# Notify bg task completion immediately
set -o notify

# Stop mail notifications
unset MAILCHECK

# default umask
umask 0022

# Terminal type
case $UNAME in
    CYGWIN* | MINGW32*)
        export TERM=cygwin
        ;;
    *)
        export TERM=xterm-256color
        ;;
esac

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------

autoload -Uz promptinit; promptinit # optionally define some options
PURE_CMD_MAX_EXEC_TIME=10
prompt pure

#-------------------------------------------------------------------------------
# Env. Configuration
#-------------------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# Proper locale
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# Always use passive mode FTP
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

#-------------------------------------------------------------------------------
# User Shell Environment
#-------------------------------------------------------------------------------

# Usage: puniq [path]
# Remove duplicate entries from a PATH style value while
# retaining the original order.
puniq() {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

case $UNAME in
    MINGW*)
        # Don't condense path, since function doesn't work here.
        ;;
    *)
        # Condense path variables
        PATH=$(puniq $PATH)
        MANPATH=$(puniq $MANPATH)
        ;;
esac

#-------------------------------------------------------------------------------
# Editor and Pager
#-------------------------------------------------------------------------------

EDITOR="vim"
export EDITOR

PAGER="less -FirSwX"
MANPAGER="$PAGER"
export PAGER MANPAGER

#-------------------------------------------------------------------------------
# Subconfigs
#-------------------------------------------------------------------------------

source ~/.zsh.d/direnv.sh
source ~/.zsh.d/go.sh
source ~/.zsh.d/qq.sh
source ~/.zsh.d/ssh-agent.sh
# source ~/.zsh.d/thefuck.sh

source $(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
