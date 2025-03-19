{ lib, stdenv, fetchurl, patchelf, ncurses5}:

let
  lpath = "${stdenv.cc.cc.lib}/lib64:" + lib.makeLibraryPath [
		(ncurses5.overrideAttrs(final: prev: {
			configureFlags = lib.lists.remove "--with-versioned-syms" prev.configureFlags;
		}))
  ];

in
stdenv.mkDerivation rec {
  name = "adom-${version}-noteye";
  version = "3.3.3";

  src = fetchurl {
    url = "https://www.adom.de/home/download/current/adom_linux_ubuntu_64_${version}.tar.gz";
    sha256 = "sha256-ST73ZZTB9qfzjc8yp2zRB/tx3RK/kXwY/errysGjU7E=";
  };

  buildCommand = ''
    . $stdenv/setup

    unpackPhase

    mkdir -pv $out
    cp -r -t $out adom/*

    chmod u+w $out/
    for l in $out/lib/*so* ; do
      chmod u+w $l
      ${patchelf}/bin/patchelf \
        --set-rpath "$out/lib:${lpath}" \
        $l
    done

    ${patchelf}/bin/patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "$out/lib:${lpath}" \
      $out/adom

    mkdir $out/bin
		mv $out/adom $out/bin/adom
    chmod +x $out/bin/adom
  '';

  meta = with lib; {
    description = "A rogue-like game with nice graphical interface";
    homepage = "http://adom.de/";
    license = licenses.unfreeRedistributable;
    maintainers = [maintainers.smironov];

    # Please, notify me (smironov) if you need the x86 version
    platforms = ["x86_64-linux"];
  };
}


