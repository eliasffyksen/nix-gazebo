{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "ignition-fuel-tools4";
  version = "4.4.0";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/ign-fuel-tools/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "1366nxy518amxs618h97jqzsl9755ig78w04s1ci3w5nir5silmq";
  };

  nativeBuildInputs = with pkgs; [
    cmake pkg-config tinyxml-2 jsoncpp libyaml libzip protobuf curl libuuid
    (callPackage (import ./ign-math6.nix) {})
    (callPackage (import ./ign-msgs5.nix) {})
    (callPackage (import ./ign-common3.nix) {})
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
    description = "Ignition Fuel Tools Library";
  };

}
