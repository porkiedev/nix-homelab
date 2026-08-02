{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  rtl-sdr-blog,
  systemd,
}:
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
  pname = "rtltcp2026";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "dlasher";
    repo = "rtltcp2026";
    rev = "v0.10.1";
    hash = "sha256-/VvbvJQS0m/l9kNiCq0TzT+ZUjBXQQmyijU3wgljJ2M=";
  };

  cargoHash = "sha256-JiebBGQ8/GaU7kSEf3JSDegMpiHtOF9kNlctfR/M/Lc=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    rtl-sdr-blog
    systemd
  ];

  meta = with lib; {
    description = "A rust implementation of rtl-tcp with better buffering and support for systemd socket activation";
    homepage = "https://github.com/dlasher/rtltcp2026";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "rtltcp2026";
    platforms = lib.platforms.linux;
  };
})
