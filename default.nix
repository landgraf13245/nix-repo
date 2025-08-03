{ pkgs ? import <nixpkgs> { } }:
let
	ngrams = import ./pkgs/ngrams {inherit pkgs;};
in
rec {
  adom = pkgs.callPackage ./pkgs/adom { };
  xilinx-env = pkgs.callPackage ./pkgs/xilinx-env { };
  i915-sriov-dkms = pkgs.callPackage ./pkgs/i915-sriov-dkms { };
  plox = pkgs.callPackage ./pkgs/plox { };
  openmw-unstable = pkgs.callPackage ./pkgs/openmw-unstable {
		mygui = mygui;
	};
  mygui = pkgs.callPackage ./pkgs/mygui { };
	elegant-grub2-themes = pkgs.callPackage ./pkgs/elegant-grub2-themes { };
  waydroid-script = pkgs.python3Packages.callPackage ./pkgs/waydroid-script { };
  ha-solarman = pkgs.python3Packages.callPackage ./pkgs/ha-solarman {};
} // ngrams
