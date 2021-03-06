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
      nodejs-12_x
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

      initExtra = ''
        . ~/.nix-profile/etc/profile.d/nix.sh

        # Installed via `brew install gnu-getopt` this is required so the brew's
        # gnu-getopt overrides the system getopt
        export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
      '';
    };
  };
}
