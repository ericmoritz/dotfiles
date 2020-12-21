{ config, lib, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./platforms/darwin.nix
    ./machines/corsha.nix
  ];
}
