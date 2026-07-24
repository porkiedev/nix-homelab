{
  description = "My collection of packages and other Nix related information for my projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          multimon-ng = pkgs.callPackage ./packages/multimon-ng.nix { };
          squelch-collector = pkgs.callPackage ./packages/squelch-collector.nix { };
          mercury = pkgs.callPackage ./packages/mercury.nix { };
        };
      }
    ) // {
      # Overlay that can be used by other flakes
      overlays.default = final: prev: {
        multimon-ng = final.callPackage ./packages/multimon-ng.nix { };
        squelch-collector = final.callPackage ./packages/squelch-collector.nix { };
        mercury = final.callPackage ./packages/mercury.nix { };
      };
    };
}
