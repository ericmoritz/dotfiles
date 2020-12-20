{unstable, pkgs, ...}:
{
  home.packages = with unstable; [
    spotify
    discord
    minecraft
    zulip
    sidequest
    zoom-us
    steam-run
    steamPackages.steamcmd
    steam

    productivity tools
    obs-studio
    google-chrome
    signal-desktop
    evince
    audacity
    firefox
    google-chrome

    pkgs.syncthing-gtk

    python-language-server
    python38Packages.pyls-isort
    python38Packages.pyls-black
  ];
}
