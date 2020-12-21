{ pkgs ? import <nixpkgs> {}, ... }:
let
  jfrog = rec {
    version = "1.42.3";
    # TODO: support linux
    url = "https://api.bintray.com/content/jfrog/jfrog-cli-go/${version}/jfrog-cli-mac-386/jfrog?bt_package=jfrog-cli-mac-386";
  };
in
{
  jfrog-cli = pkgs.runCommand "jfrog-cli-${jfrog.version}" {
    src = pkgs.fetchurl {
      url = jfrog.url;
      sha256 = "8e36d207f6281a3485717b732221cee5aed6887b1d8907de83f244e052c66bdd";
    };
  } ''
  mkdir -p $out/bin
  cp $src $out/bin/jfrog
  chmod +x $out/bin/jfrog
  '';
}
