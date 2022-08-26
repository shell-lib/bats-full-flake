{
  description = "Bats-core and all bats helper libs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bats-most.url = "github:shell-lib/bats-most-flake";
    bats-detik.url = "github:shell-lib/bats-detik-flake";
  };
  outputs = { self, nixpkgs, flake-utils, ... };
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {inherit system; };
      bats-full = pkgs.symlinkJoin {
        name = "bats-full";
        paths = [
          bats-most.defaultPackage.${system}
          bats-detik.defaultPackage.${system}
        ];
      packages = {default = bats-full;};
      });
}
