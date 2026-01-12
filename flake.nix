{
  description = "macroquad wasm dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    fenix.url = "github:nix-community/fenix";
  };

  outputs = { self, nixpkgs, flake-utils, fenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        toolchain = fenix.packages.${system}.stable.toolchain;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            toolchain
            pkgs.rust-analyzer

            pkgs.gettext

            pkgs.jq
            pkgs.wasm-pack
            pkgs.binaryen   # provides wasm-opt (optional)
          ];

        };
      });
}

