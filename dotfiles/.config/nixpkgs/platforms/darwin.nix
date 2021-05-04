{ ... }:
let
  personal = (import ../pkgs/personal.nix) { };
  sources = import ../nix/sources.nix;
  unstable = import sources.nixpkgs { config.allowUnfree = true; };
in {
  config = {
    home.packages = [
      personal.jfrog-cli
      unstable.terminal-notifier
      unstable.nodejs-14_x
      unstable.vagrant
      unstable.azure-cli
      unstable.terraform_0_15
      unstable.awscli
    ];

    home.sessionVariables = {
      GOPRIVATE = "github.com/corshatech/*";
      NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
    };

    programs.zsh = {
      shellAliases = {
        flushdns =
          "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
      };
    };
  };
}
