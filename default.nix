{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
}:

stdenv.mkDerivation rec {
  name = "gazebo11";
  version = "11.9.0";

  src = builtins.fetchTarball {
    url = "https://github.com/osrf/gazebo/archive/refs/tags/${name}_${version}.tar.gz";
    sha256 = "02cv2p0vz1w8xnwnvrrl0plmwg47298is31bv0mdgdsqn70ldwb0";
  };

  nativeBuildInputs = with pkgs; [
    cmake pkg-config freeimage protobuf libGL libtar tinyxml tinyxml-2 openal curl tbb ogre libccd gts bullet libusb1 boost ffmpeg libuuid zeromq cppzmq xorg.libX11 libsodium
    libsForQt5.qwt
    (callPackage (import ./ign-fuel-tools4.nix) {})
    (callPackage (import ./ign-common3.nix) {})
    (callPackage (import ./sdformat9.nix) {})
    (callPackage (import ./ign-transport8.nix) {})
    (callPackage (import ./ign-msgs5.nix) {})
    (callPackage (import ./ign-math6.nix) {})
    (callPackage (import ./ign-cmake2.nix) {})
    (callPackage (import ./dart-sim.nix) {})
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
