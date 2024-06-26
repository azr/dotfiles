#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
SSH_ENV=$HOME/.ssh/environment

function _start_ssh_agent {
    if [ which ssh-agent >/dev/null 2>&1 ]; then
      # all good
    else
      return
    fi

    if [ ! -d $(dirname "$SSH_ENV") ]; then
        mkdir -p $(dirname $SSH_ENV)
        chmod 0700 $(dirname $SSH_ENV)
    fi

    ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 0600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    ssh-add
}

function start_ssh_agent {
  # Source SSH agent settings if it is already running, otherwise start
  # up the agent proprely.
  if [ -f "${SSH_ENV}" ]; then
      . ${SSH_ENV} > /dev/null
      # ps ${SSH_AGENT_PID} doesn't work under cywgin
      ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
          start_ssh_agent
      }
  else
      case $UNAME in
        MINGW*)
          ;;
        *)
          start_ssh_agent
          ;;
      esac
  fi
}
