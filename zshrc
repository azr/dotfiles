# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PAT
fpath=(/usr/local/share/zsh-completions $fpath)

# allow using bash completions
autoload -U +X bashcompinit && bashcompinit

export ZSH="/Users/azr/.oh-my-zsh"

# commands
alias k="clear;l"
alias freewifi="sudo ifconfig en0 ether `openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`"
alias rnd="cat /dev/urandom | base64 | tr -dc '0-9a-zA-Z' | head -c 10"

# lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit # optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

prompt pure

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/direnv.sh
source ~/.zsh/go.sh
source ~/.zsh/qq.sh
source ~/.zsh/ssh-agent.sh
source ~/.zsh/thefuck.sh
