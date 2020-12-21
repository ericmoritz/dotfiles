{ config, lib, pkgs, ... }:

with lib;

let
  # Import sources
  sources = import ./nix/sources.nix;
  unstable = import sources.nixpkgs-unstable {
    config.allowUnfree = true;
    # config.allowUnsupportedSystem = true;
  };
  private = import sources.private-nix { };
  personal = pkgs.callPackage (import ./pkgs/personal.nix) { };

  # Configure doom-emacs
  doom-emacs = unstable.callPackage (import sources.nix-doom-emacs) {
     doomPrivateDir = ./doom.d;
  };

  # NPM Packages not in the NixOS repo
  adhocNode = pkgs.callPackage (import ./pkgs/node) {};

in
{
  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "20.09";

    home.packages = with unstable; [
      aws-iam-authenticator

      # fonts
      nanum-gothic-coding
      symbola # emoji font for doom-emacs
      private.dankmono
      comic-relief

      # nix stuff
      niv

      # productivity tools
      doom-emacs
      ripgrep
      proselint
      vscode

      # Tools needed by doom emacs's modules
      fd
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science]))
      nixfmt
      shellcheck
      proselint
      pandoc
      mdl
      nodePackages.js-beautify
      adhocNode.stylelint
      gnutls
      gnupg
      pass
      pinentry-curses
      graphviz
      jsonnet
      tanka
      kubernetes
      kubernetes-helm
      kubectx
      helmfile
      sops

      # go tools for Doom, see https://github.com/hlissner/doom-emacs/tree/develop/modules/lang/go
      gotools # for gopls Go's LSP server
      gore
      godef
      gocode
      goimports
      gotests
      gomodifytags
      golangci-lint

      # Haskell tooling
      zlib.dev
      zlib.out
      pkgconfig
      stack
      ghc
      haskellPackages.ghcide
      haskellPackages.brittany
      ormolu

      # Python tooling
      python3
      python38Packages.pytest
      python38Packages.nose
      python38Packages.black
      python38Packages.pyflakes
      python38Packages.isort
      python38Packages.pygments

      # misc
      xdg_utils
      sqlite
      thefuck
      fortune
    ];

    programs = {
      go = rec {
        enable = true;
        goPath = "go";
        goBin = "${goPath}/bin";
      };

      git = {
        extraConfig = {
          url = {
            "git@github.com:" = {
              insteadOf = "https://github.com/";
            };
          };
          pull = {
            rebase = true;
          };
        };
      };
    };

    programs.zsh = {
      enable = true;
      initExtra = ''
        # Installed via `brew install gnu-getopt` this is required so the brew's
        # gnu-getopt overrides the system getopt
        export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
        '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "emacs" "helm" "kubectl" "thefuck"
                    "golang" "themes" "bgnotify" ];
        # theme = "nanotech";
        theme = "ys";
      };
    };
    home.sessionVariables = {
      CLICOLOR=1;
    };

    home.file = {
      ".emacs.d/init.el".text = ''
        (load "default.el")
      '';

      ".zprofile".text = ''
      . /Users/eric/.nix-profile/etc/profile.d/nix.sh
      '';
    };


    fonts.fontconfig.enable = true;
  };
}
