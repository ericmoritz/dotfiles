# -*- mode: sh; sh-shell: bash -*-

bash "$HOME/dotfiles/sync.sh"
for i in "$HOME"/dotfiles/profile.d/*.sh; do
  source "$i"
done
