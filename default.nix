{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "gazebo";
  version = "11";

  src = builtins.fetchGit {
    url = "https://github.com/osrf/gazebo";
    ref = "gazebo11";
  };

  nativeBuildInputs = with pkgs; [
    cmake pkg-config freeimage protobuf libGL libtar tinyxml tinyxml-2 openal hdf5 curl dart tbb ogre libccd gts bullet libusb1 boost ffmpeg libuuid zeromq cppzmq xorg.libX11 libsodium
    libsForQt5.qwt
    (callPackage (import ../nix-sdformat9) {})
    (callPackage (import ../nix-ign-math) {})
    (callPackage (import ../nix-ign-msgs5) {})
    (callPackage (import ../nix-ign-transport8) {})
    (callPackage (import ../nix-ign-common3) {})
    (callPackage (import ../nix-ign-fuel-tools4) {})
    (callPackage (import ../nix-ign-cmake) {})
  ];
  buildInputs = with pkgs; [ libsForQt5.qt5.wrapQtAppsHook ];

  configurePhase = ''
  mkdir build && cd build
  cmake .. -DCMAKE_INSTALL_PREFIX=$out
  '';

  buildPhase = ''
    make -j16
  '';

  installPhase = ''
  make install
  '';

  meta = {
    description = "Gazebo Simulator";
  };

}
