{ pkgs ? import <nixpkgs> { } }:

{
#  lib = import ./lib { inherit pkgs; }; # functions
#  modules = import ./modules; # NixOS modules
#  overlays = import ./overlays; # nixpkgs overlays

  adom = pkgs.callPackage ./pkgs/adom { };
  xilinx-env = pkgs.callPackage ./pkgs/xilinx-env { };
}
