# dotfiles

These are my dotfiles and home-manager configuration

## Requirements

- NixOS or [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://github.com/rycee/home-manager)

## Bootstrap

``` sh
nix-shell -p stow --run 'stow -t ~ dotfiles'
home-manager switch
```

## TODO

- [x] Use stow to setup the initial symlinks
- [x] Setup eric-t470 for home-manager
- [x] Setup work computer for home-manager
