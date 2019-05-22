# -*- mode: sh; sh-shell: bash -*-
source "$HOME/dotfiles/shared.sh"

for i in "$HOME"/dotfiles/profile.d/*.sh; do
  source "$i"
done
