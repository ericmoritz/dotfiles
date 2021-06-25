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
      zoom-us
      steam-run
      steamPackages.steamcmd
      steam

      obs-studio
      google-chrome
      signal-desktop
      evince
      firefox
      zotero

      openscad

      # broken
      # syncthing-gtk

      element-desktop
      gimp
      inkscape

      # gnome themes
      arc-theme
      arc-icon-theme

      gnomeExtensions.syncthing-indicator
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

    home.sessionVariables = {
      NIX_PATH = "$HOME/.nix-defexpr/channels$\{NIX_PATH:+:\}$NIX_PATH";
    };

    fonts.fontconfig.enable = true;
    services.syncthing.enable = true;
  };

}
