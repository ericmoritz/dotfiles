# dotfiles

These are my dotfiles and home-manager configuration

## Requirements

- NixOS or [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://github.com/rycee/home-manager)

## Bootstrap

``` sh
nix-shell -p stow --run 'stow -t ~ dotfiles'
git clone https://github.com/hlissner/doom-emacs.git ~/.emacs.d
home-manager switch
~/.emacs.d/bin/doom sync
```

## TODO

- [X] Use stow to setup the initial symlinks
- [X] Setup eric-t470 for home-manager
- [ ] Setup work computer for home-manager
- [ ] Use NixOps to deploy a etc/nixos/configuration.nix to localhost
