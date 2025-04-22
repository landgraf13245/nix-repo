{ pkgs ? import <nixpkgs> { } }:

{
  adom = pkgs.callPackage ./pkgs/adom { };
  xilinx-env = pkgs.callPackage ./pkgs/xilinx-env { };
  i915-sriov-dkms = pkgs.callPackage ./pkgs/i915-sriov-dkms { };
}
