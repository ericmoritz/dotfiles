{ config, pkgs, ... }:
let
  sources = import ./nix/sources.nix;
  unstable = import sources.nixpkgs-unstable { config.allowUnfree = true;};
  doom-emacs = pkgs.callPackage (import sources.nix-doom-emacs) {
     doomPrivateDir = ./doom.d;
  };

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


  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fun
    unstable.spotify
    unstable.discord
    unstable.slack

    # nix stuff
    niv
    direnv
   
    # productivity tools
    doom-emacs
    obs-studio
    ripgrep
    google-chrome
    signal-desktop
    proselint
    evince
    audacity
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

  programs.bash.enable = true;
  programs.bash.initExtra = ''
    eval "$(direnv hook bash)"
    PATH=$PATH:~/.npm-global/bin
  '';
  
  home.file.".emacs.d/init.el".text = ''
     (load "default.el")
  '';

  services.lorri.enable = true;
}
