{ }:

# Pinned versions of packages for work
let
  # Import sources
  sources = import ./sources.nix;

  # We have to pin 1.38.0 of golangci-lint at work
  golangci-lint = import sources.golangci-lint {};

  # We have to pin 3.6.1 of sops at work
  sops = import sources.sops {
    config.allowUnfree = true;
  };

in
{
  golangci-lint = golangci-lint.golangci-lint;
  sops = sops.sops;
  kubernetes-helm = sops.kubernetes-helm;
}
