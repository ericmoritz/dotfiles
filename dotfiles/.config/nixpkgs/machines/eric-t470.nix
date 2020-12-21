{ ... }:
{
  imports = [
    ../platforms/nixos.nix
  ];

  config = {
    home.username = "eric";
    home.homeDirectory = "/home/eric";
    programs.git = {
      enable = true;
      userName = "Eric Moritz";
      userEmail = "eric.moritz@gmail.com";
    };
  };
}
