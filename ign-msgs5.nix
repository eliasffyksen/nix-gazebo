{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "ignition-msgs5";
  version = "5.8.1";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/ign-msgs/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "1c2rwms02sbr55fm75zjspq72i81v073rfh32g59kq3px4kircck";
  };

  nativeBuildInputs = with pkgs; [
    cmake protobuf tinyxml-2
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
    description = "Ignition Messages Library";
  };

}
