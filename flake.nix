{
  description = "Bats-core and some bats helper libs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bats-core.url = "github:shell-lib/bats-core-flake";
    bats-assert.url = "github:shell-lib/bats-assert-flake";
    bats-support.url = "github:shell-lib/bats-support-flake";
    bats-file.url = "github:shell-lib/bats-file-flake";
  };
  outputs = { self, nixpkgs, flake-utils, bats-core, bats-assert, bats-support, bats-file, ... }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in rec {
      packages.default = pkgs.writeShellApplication  {
        name = "bats";
        runtimeInputs = [
            bats-core.packages.${system}.default
            bats-assert.packages.${system}.default
            bats-support.packages.${system}.default
            bats-file.packages.${system}.default
        ];
        text = ''
          # Allow the runtimeInput libraries to be loaded with bat's 'bats_load_library'
          # Since writeShellApplication puts these on our path, we can just use the path as BATS_LIB_PATH
          # See https://bats-core.readthedocs.io/en/stable/writing-tests.html#bats-load-library-load-system-wide-libraries
          BATS_LIB_PATH="$PATH"
          export BATS_LIB_PATH
          bats "$@"
        '';
      };
  });
}
