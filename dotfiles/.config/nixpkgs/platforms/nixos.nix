{ ... }:
let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs { config.allowUnfree = true; };
in {
  config = {
    home.packages = with pkgs; [
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
      signal-desktop
      evince
      audacity
      firefox

      openscad

      # broken
      # syncthing-gtk

      element-desktop
      gimp
      inkscape
      teams
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
        "x-scheme-handler/msteams" = [ "teams.desktop" ];
      };
    };

    fonts.fontconfig.enable = true;
  };

}
