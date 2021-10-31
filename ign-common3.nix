{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "ignition-common3";
  version = "3.14.0";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/ign-common/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "0rwimcslsp0smjnjdhgrlf7zrsiphayr7jdbzigygw8x6i2ah1x9";
  };

  nativeBuildInputs = with pkgs; [
    cmake pkg-config libuuid freeimage gts tinyxml-2 ffmpeg
    (callPackage (import ./ign-math6.nix) {})
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
    description = "Ignition Common Library";
  };

}
