{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "sdformat9";
  version = "9.6.1";

  src = builtins.fetchTarball {
    url = "https://github.com/ignitionrobotics/sdformat/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "1jm0mw11mab6qnk004nbk6xj9wvqiy7xbkpj8ibm125vq7zbc4yy";
  };

  nativeBuildInputs = with pkgs; [
    cmake tinyxml tinyxml-2 pkg-config urdfdom ruby
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
    description = "SDFormat Library";
  };

}
