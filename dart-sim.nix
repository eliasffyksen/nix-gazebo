{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "dart-sim";
  version = "6.6.2";

  src = builtins.fetchTarball {
    url = "https://github.com/dartsim/dart/archive/refs/tags/v${version}.tar.gz";
    sha256 = "0nqn59qi33pk1kzfwsmswxg21jxg76cmqc7h03in45x5f9w5wyyh";
  };

  nativeBuildInputs = with pkgs; [ cmake pkg-config eigen libccd fcl assimp boost ];
  buildInputs = with pkgs; [ ];

  configurePhase = ''
    mkdir build && cd build
    cmake .. -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_PREFIX=$out
  '';

  buildPhase = ''
    make -j16
  '';

  installPhase = ''
    make install
  '';

  meta = {
    description = "Dart Physics Simulator Library";
  };

}
