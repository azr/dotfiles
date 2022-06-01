# Setup TTY for GPG
export GPG_TTY=$(tty)

function start_gpg_agent {
    if [ ! -x "$(command -v gpgconf)" ]; then
        return
    fi

    gpgconf --launch gpg-agent
}

case $UNAME in
  MINGW*)
    ;;
  *)
    start_gpg_agent
  ;;
esac
