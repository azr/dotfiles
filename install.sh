#!/usr/bin/env bash
#
# This installation is destructive, as it removes exisitng files/directories.
# Use at your own risk.

# Get path to the current script
SCRIPT_NAME="$(basename ${BASH_SOURCE[0]})"
pushd $(dirname ${BASH_SOURCE[0]}) > /dev/null
SCRIPT_DIR=$(pwd)
popd > /dev/null

# copy or symlink all the dotfiles
UNAME=$(uname | tr '[:upper:]' '[:lower:]')
for path in $SCRIPT_DIR/*; do
  name=$(basename $path)
  case $name in
    *.md|*.sh) continue;;
  esac

  # If there exists a platform-specific version, then use that
  if [ -e "${path}.${UNAME}" ]; then
    echo "Using platform-specific ${name} for ${UNAME}"
    path="${path}.${UNAME}"
  fi

  target=".$name"

  # Build our complete path to the home directory
  target="$HOME/$target"
  if [ -h $target -o -f $target ]; then
    rm $target
  elif [ -d $target ]; then
    rm -rf $target
  fi

  case $UNAME in
    cygwin* | mingw32*)
      cp -R $path "$target"
      echo "Copied $name to $target."
      ;;
    *)
      ln -s $path "$target"
      echo "Linked $name to $target."
      ;;
  esac
done

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo now add /opt/homebrew/bin/zsh to /etc/shells and run chsh -s /opt/homebrew/bin/zsh
