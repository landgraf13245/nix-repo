{ pkgs ? import <nixpkgs> { } }:

{
#  lib = import ./lib { inherit pkgs; }; # functions
#  modules = import ./modules; # NixOS modules
#  overlays = import ./overlays; # nixpkgs overlays

  adom = pkgs.callPackage ./pkgs/adom { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
