{ pkgs, ... }:
let
  sources = import ../nix/sources.nix;
  unstable = import sources.nixpkgs-unstable { config.allowUnfree = true; };
in {
  config = {
    home.packages = with unstable; [
      slack
      spotify
      discord
      minecraft
      zulip
      sidequest
      zoom-us
      steam-run
      steamPackages.steamcmd
      steam

      obs-studio
      google-chrome
      pkgs.signal-desktop
      evince
      audacity
      firefox

      pkgs.syncthing-gtk

      python-language-server
      python38Packages.pyls-isort
      python38Packages.pyls-black
      element-desktop
      gimp
      inkscape
    ];
    home.file = {
      ".local/share/applications/org-protocol.desktop".text = ''
        [Desktop Entry]
        Name=org-protocol
        Exec=emacsclient %u
        Type=Application
        Terminal=false
        Categories=System;
        MimeType=x-scheme-handler/org-protocol;
      '';
    };

    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
      };
      defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      };
    };

    fonts.fontconfig.enable = true;
  };

}
