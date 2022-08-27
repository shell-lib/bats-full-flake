{
  description = "Bats-core and all bats helper libs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bats-most.url = "github:shell-lib/bats-most-flake";
    bats-detik.url = "github:shell-lib/bats-detik-flake";
  };
  outputs = { self, nixpkgs, flake-utils, bats-most, bats-detik, ... }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {inherit system; };
    in rec {
      packages.default = pkgs.symlinkJoin {
        name = "bats-full";
        paths = [
          bats-most.packages.${system}.default
          bats-detik.packages.${system}.default
        ];
      };
    });
}
