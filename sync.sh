#!/usr/bin/env bash
set -euo pipefail
source "$HOME/dotfiles/shared.sh"
symlink() {
  src="$1"
  dest="$2"
  # If the dest exists, fail
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "ERROR: $dest exists and is not a symlink, please merge contents with $src"
  elif [ ! -e "$dest" ]; then
    echo "INFO: linking $dest to $src"
    ln -s "$src" "$dest"
  fi
}
symlink "$HOME/dotfiles/spacemacs.d" "$HOME/.spacemacs.d"
sudo pip3 install virtualenvwrapper
if which pacman; then
    sudo pacman -S ansible
fi
ansible-galaxy install nephelaiio.golang
