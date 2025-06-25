{ stdenvNoCC
, fetchFromGitHub
, bash
, lib
, set_theme ? "forest"
, set_type ? "window"
, set_side ? "left"
, set_color ? "dark"
, set_screen ? "1080p"
, set_logo ? "default"
}:

assert lib.elem set_theme [ "forest" "mojave" "mountain" "wave" ];
assert lib.elem set_type [ "window" "float" "sharp" "blur" ];
assert lib.elem set_side [ "left" "right" ];
assert lib.elem set_color [ "dark" "light" ];
assert lib.elem set_screen [ "1080p" "2k" "4k" ];
assert lib.elem set_logo [ "default" "system" ];

stdenvNoCC.mkDerivation {
  pname = "elegent";
	version = "1.0";
	src = fetchFromGitHub{
		owner = "vinceliuice";
		repo = "Elegant-grub2-themes";
		rev = "2025-03-25";
		hash = "sha256-M9k6R/rUvEpBTSnZ2PMv5piV50rGTBrcmPU4gsS7Byg=";
	};

  dontConfigure = true;
  dontFixup = true;

	nativeBuildInputs = [
		bash
	];

	buildPhase = ''
		bash ./generate.sh --theme ${set_theme} --type ${set_type} --side ${set_side} --color ${set_color} --logo ${set_logo}
	'';

  installPhase = ''
		cp -r Elegant-${set_theme}-${set_type}-${set_side}-${set_color} $out
  '';
}

