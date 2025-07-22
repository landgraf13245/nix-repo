{ lib, stdenv, pkgs}:
pkgs.buildFHSEnv {
	name = "xilinx-env";
	targetPkgs = pkgs: with pkgs; let
		ncurses' = ncurses5.overrideAttrs (old: {
			configureFlags = old.configureFlags ++ [ "--with-termlib" ];
			postFixup = "";
		});
	in [
		bash
		coreutils
		zlib
		lsb-release
		stdenv.cc.cc
		ncurses'
		(ncurses'.override { unicodeSupport = false; })
		xorg.libXext
		xorg.libX11
		xorg.libXrender
		xorg.libXtst
		xorg.libXi
		xorg.libXft
		xorg.libxcb
		xorg.libxcb
		freetype
		fontconfig
		glib
		gtk2
		gtk3
		libxcrypt-legacy # required for Vivado
		python3
		(libidn.overrideAttrs (_old: {
			src = fetchurl {
				url = "mirror://gnu/libidn/libidn-1.34.tar.gz";
				sha256 = "sha256-Nxnil18vsoYF3zR5w4CvLPSrTpGeFQZSfkx2cK//bjw=";
			};
		}))
		opencl-clhpp
		ocl-icd
		opencl-headers
		graphviz
		(lib.hiPrio gcc)
		unzip
		nettools
	];
	profile = ''
		export LC_NUMERIC="en_US.UTF-8"
		export _JAVA_AWT_WM_NONREPARENTING=1
	'';
	runScript = "zsh";
}
