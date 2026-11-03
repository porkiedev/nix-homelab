{ lib, rustPlatform, fetchFromGitHub }:
# NOTE: We have to use rust-overlay (i.e. a newer rustc version) to fix the error outlined in https://github.com/rust-lang/rust/issues/159669
with import <nixpkgs> {
  overlays = [
    (import (fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
  ];
};
let
  rustPlatform = makeRustPlatform {
    cargo = rust-bin.stable.latest.minimal;
    rustc = rust-bin.stable.latest.minimal;
  };
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "squelch-collector";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "porkiedev";
    repo = "squelch-collector";
    rev = "079c4f31a03be84b26cda2c47ad4fea36d93cb17";
    hash = "sha256-Ey1nt1Yx9SB6bY8RW5ICxXZ7FyDIPwBmvxO0fHkbHPI=";
  };

  cargoHash = "sha256-brir+XbwC9HZhjLIWeSrKHwhtoQwmu7RgP/sBx6+KnE=";

  meta = with lib; {
    description = "A tool for parsing, aggregating, and forwarding the output of various RF tools to a SurrealDB instance for fun and monitoring purposes";
    homepage = "https://github.com/porkiedev/squelch-collector";
    mainProgram = "squelch-collector";
  };
})
