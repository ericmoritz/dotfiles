{ config, pkgs, ... }:
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

  # Import the platform and machine specific records
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  mkPlatform =
    if isDarwin
    then (import ./platforms/darwin.nix)
    else (import ./platforms/nixos.nix ) ;
  platform = mkPlatform { inherit unstable pkgs personal; };
  machine = (import ./machine.nix) {};
in
{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = machine.username;
  home.homeDirectory = machine.homeDirectory;

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
    slack
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

    # misc
    xdg_utils
    sqlite
  ] ++ platform.packages;

  programs = {
    go = rec {
      enable = true;
      goPath = "go";
      goBin = "${goPath}/bin";
    };

    git = machine.git // {
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

  programs.bash.enable = true;
  programs.bash.initExtra = ''
    # eval "$(direnv hook bash)"
    PATH=$PATH:~/.npm-global/bin

  '';

  home.file = {
    ".emacs.d/init.el".text = ''
      (load "default.el")
    '';

    ".local/share/applications/org-protocol.desktop".text = ''
      [Desktop Entry]
      Name=org-protocol
      Exec=emacsclient %u
      Type=Application
      Terminal=false
      Categories=System;
      MimeType=x-scheme-handler/org-protocol;
    '';

    ".zprofile".text = ''
    . /Users/eric/.nix-profile/etc/profile.d/nix.sh
    '';
  };

#   xdg.mimeApps = {
#     enable = true;
#     associations.added = {
#       "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
#     };
#     defaultApplications = {
#       "text/html" = [ "firefox.desktop" ];
#       "x-scheme-handler/http" = [ "firefox.desktop" ];
#       "x-scheme-handler/https" = [ "firefox.desktop" ];
#       "x-scheme-handler/about" = [ "firefox.desktop" ];
#       "x-scheme-handler/unknown" = [ "firefox.desktop" ];
#     };
#   };

  # fonts.fontconfig.enable = true;

}
