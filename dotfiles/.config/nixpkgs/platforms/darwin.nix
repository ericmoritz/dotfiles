{...}:
let
  personal = (import ../pkgs/personal.nix) {};
in
{
  packages = [
    personal.jfrog-cli
  ];
}
