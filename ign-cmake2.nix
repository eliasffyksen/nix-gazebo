{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "ignition-cmake2";
  version = "2.9.0";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/ign-cmake/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "0yg5prhkgysp2wqrsh71mv582ry154sm14ps20rsq138zhnf9751";
  };

  nativeBuildInputs = with pkgs; [ cmake ];
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
    description = "Ignition CMake";
  };

}
