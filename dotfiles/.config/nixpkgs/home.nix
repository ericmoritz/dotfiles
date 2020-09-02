{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/32b46dd897ab2143a609988a04d87452f0bbef59.tar.gz; # unstable

  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/77ca84bce93e928c59ecda5113e90df64109f41b.tar.gz; # master as of 2020-08-31
   }) {
     doomPrivateDir = ./doom.d;  # Directory containing your config.el init.el
                                 # and packages.el files
   };

  comma = pkgs.callPackage
    (fetchTarball
      https://github.com/Shopify/comma/archive/4a62ec17e20ce0e738a8e5126b4298a73903b468.tar.gz) # master as of 2020-08-31
    {};

  # NPM Packages not in the NixOS repo
  adhocNode = pkgs.callPackage (import ./pkgs/node) {};
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  # add the unstable channel so that we can cherry pick from it
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # productivity tools
    doom-emacs
    obs-studio
    ripgrep
    google-chrome
    signal-desktop
    slack
    proselint
    discord
    evince
    comma

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

    # go tools for Doom, see https://github.com/hlissner/doom-emacs/tree/develop/modules/lang/go
    gotools # for gopls Go's LSP server
    unstable.gore
    godef
    gocode
    goimports
    gotests
    gomodifytags
    # golangci-lint
    syncthing-gtk

    # Haskell tooling
    zlib.dev
    zlib.out
    pkgconfig
    stack
    ghc
    haskellPackages.ghcide
    haskellPackages.brittany
    ormolu

  ];

  programs = {
    go = rec {
      enable = true;
      goPath = "go";
      goBin = "${goPath}/bin";
    };

    git = {
      enable = true;
      userName = "Eric Moritz";
      userEmail = "eric.moritz@gmail.com";
    };
  };

  home.file.".profile".text = ''
  '';
  home.file.".emacs.d/init.el".text = ''
     (load "default.el")
  '';
}
