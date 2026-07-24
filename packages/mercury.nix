{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, alsa-lib
, libpulseaudio
, hamlib_4
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "mercury";
  version = "1.9.9-unstable-2026-07-01";

  src = fetchFromGitHub {
    owner = "Rhizomatica";
    repo = "mercury";
    rev = "763ac83cf0d668e3b798897ec4a93eec5897c710";
    hash = "sha256-TftvFnm9ZYK13k/msWYv9wb134et8H+u5bPhCRRBdjk=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ alsa-lib libpulseaudio hamlib_4 ];

  enableParallelBuilding = true;
  
  installFlags = [ "prefix=${placeholder "out"}" ];

  meta = with stdenv.lib; {
    description = "HERMES OFDM HF modem with ARQ data link and VARA-style TCP TNC interface";
    homepage = "https://github.com/Rhizomatica/mercury";
    license = with licenses; [ gpl3Only lgpl21Only ];
    platforms = platforms.linux;
    mainProgram = "mercury";
  };
})
