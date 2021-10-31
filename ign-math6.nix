{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "ignition-math6";
  version = "6.9.2";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/ign-math/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "04h23hfpix60k7fmgl2m3vrp16i58lc388qw1gdda896266m07y9";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    (callPackage (import ./ign-cmake2.nix) {})
  ];
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
    description = "Ignition Math Library";
  };

}
