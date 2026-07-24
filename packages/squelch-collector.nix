{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "squelch-collector";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "porkiedev";
    repo = "squelch-collector";
    rev = "ba95bc7989770842e4d0f4c36e4c36f9edc830da";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash; # same trick -- run once, copy the real hash from the error

  meta = with lib; {
    description = "A tool for parsing, aggregating, and forwarding the output of various RF tools to a SurrealDB instance for fun and monitoring purposes";
    homepage = "https://github.com/porkiedev/squelch-collector";
    mainProgram = "squelch-collector";
  };
}
