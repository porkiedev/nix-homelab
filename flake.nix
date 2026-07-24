{
  description = "My collection of packages and other Nix related information for my projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import rust-overlay)
          ];
        };
        
        rustToolchain = pkgs.rust-bin.stable.latest.default;
        rustPlatform = pkgs.makeRustPlatform {
          cargo = rustToolchain;
          rustc = rustToolchain;
        };
      in
      {
        packages = {
          multimon-ng = pkgs.callPackage ./packages/multimon-ng.nix { };
          squelch-collector = pkgs.callPackage ./packages/squelch-collector.nix {
            inherit rustPlatform;
          };
          mercury = pkgs.callPackage ./packages/mercury.nix { };
        };
      }
    ) // {
      overlays.default = final: prev:
      let
        rustToolchain = rust-bin.stable.latest.default;
        rustPlatform = final.makeRustPlatform {
          cargo = rustToolchain;
          rustc = rustToolchain;
        };
      in
      {
        multimon-ng = final.callPackage ./packages/multimon-ng.nix { };
        squelch-collector = final.callPackage ./packages/squelch-collector.nix {
          inherit rustPlatform;
        };
        mercury = final.callPackage ./packages/mercury.nix { };
      };
    };
}
