# Cherry-pick some unstable packages
self: super:
let unstable = builtins.fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {
  gore = (import unstable { }).gore;
}
