{ ... }:
let
  personal = (import ../pkgs/personal.nix) { };
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs { config.allowUnfree = true; };
in {
  config = {
    home.packages = with pkgs; [
      personal.jfrog-cli
      terminal-notifier
      nodejs-14_x
      vagrant
      azure-cli
      terraform_0_15
      awscli
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
