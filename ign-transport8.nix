{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "ignition-transport8";
  version = "8.2.1";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/ign-transport/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "0i5qm2j698am3ghmnh6ycqzbc4sqwhwlwgwx0r6nx9k581m99swm";
  };

  nativeBuildInputs = with pkgs; [
    cmake protobuf pkg-config zeromq cppzmq libuuid sqlite libsodium tinyxml-2
    (callPackage (import ./ign-math6.nix) {})
    (callPackage (import ./ign-msgs5.nix) {})
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
    description = "Ignition Transport Library";
  };

}
