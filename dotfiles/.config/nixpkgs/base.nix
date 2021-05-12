{ config, lib, ... }:

with lib;

let
  # Import sources
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
  };

  # We have to pin 3.6.1 of sops at work
  sops_pkgs = import sources.sops {
    config.allowUnfree = true;
  };

  # private packages like the non-free Dank Mono font
  private = import sources.private-nix { };

  # Configure doom-emacs
  doom-emacs = pkgs.callPackage (import sources.nix-doom-emacs) {
    doomPrivateDir = ./doom.d;
  };

in {
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

    home.packages = with pkgs; [
      aws-iam-authenticator

      # fonts
      nanum-gothic-coding
      symbola # emoji font for doom-emacs
      private.dankmono
      comic-relief
      julia-mono

      # nix stuff
      niv

      # tools
      doom-emacs
      ripgrep
      proselint
      vscode
      gitAndTools.hub

      # Tools needed by doom emacs's modules
      fd
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
      nixfmt
      shellcheck
      proselint
      pandoc
      mdl
      nodePackages.js-beautify
      nodePackages.stylelint
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
      sops_pkgs.sops

      # go tools for Doom, see https://github.com/hlissner/doom-emacs/tree/develop/modules/lang/go
      gopls
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
      python38Packages.mypy
      python38Packages.python-language-server
      python38Packages.pyls-mypy
      python38Packages.pyls-black

      # misc
      xdg_utils
      sqlite
      unixtools.watch
      wrk
    ];

    programs = {
      go = rec {
        enable = true;
        package = pkgs.go_1_16;
        goPath = "go";
        goBin = "${goPath}/bin";
      };

      git = {
        extraConfig = {
          url = { "git@github.com:" = { insteadOf = "https://github.com/"; }; };
          pull = { rebase = true; };
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
      shellAliases = {
        k8s_secrets = "jq '.data | with_entries(.value |= (. | @base64d))'";
      };
      oh-my-zsh = {
        enable = true;
        plugins =
          [ "git" "sudo" "helm" "kubectl" "golang" "themes" "bgnotify" ];
        # theme = "nanotech";
        # theme = "mlh";
        theme = "refined";
        # theme = "rkj-repos";
        # theme = "essembeh";
      };
    };
    home.sessionVariables = {
      CLICOLOR = 1;
      EDITOR = "emacsclient";
    };

    home.file = {
      ".emacs.d/init.el".text = ''
        (load "default.el")
      '';

    };

    fonts.fontconfig.enable = true;
  };
}
