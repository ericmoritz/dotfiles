{...}:
let
  personal = (import ../pkgs/personal.nix) {};
  sources = import ../nix/sources.nix;
  unstable = import sources.nixpkgs-unstable {
    config.allowUnfree = true;
  };
in
{
  config = {
    home.packages = [
      personal.jfrog-cli
      unstable.terminal-notifier
    ];
  };
}
