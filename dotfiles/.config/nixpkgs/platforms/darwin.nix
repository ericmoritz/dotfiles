{...}:
let
  personal = (import ../pkgs/personal.nix) {};
in
{
  config = {
    home.packages = [
      personal.jfrog-cli
    ];
  };
}
