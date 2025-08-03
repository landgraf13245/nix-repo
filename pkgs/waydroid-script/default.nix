{
  stdenv,
  lib,
  buildPythonApplication,
  fetchFromGitHub,
  replaceVars,
  inquirerpy,
  requests,
  tqdm,
  lzip,
  util-linux,
  nix-update-script,
	setuptools,
}:
let
  pname = "waydroid-script";
  version = "0-unstable-2024-01-20";
  src = fetchFromGitHub {
    repo = "waydroid_script";
    owner = "casualsnek";
    rev = "32d21c8074c17bfbab70f7158b80464227821424";
    hash = "sha256-dnQBDcHM7fG+w7YilbKT2kon4cRfGprhfL3v85z4fdw=";
  };

  resetprop = stdenv.mkDerivation {
    pname = "resetprop";
    inherit version src;
    dontBuild = true;
		installPhase = ''
      mkdir -p $out/share
      cp -r bin/* $out/share/
    '';
  };
in
buildPythonApplication rec {
  inherit pname version src;

  pyproject = true;
	build-system = [
		setuptools
	];

  propagatedBuildInputs = [
    inquirerpy
    requests
    tqdm

    lzip
    util-linux
  ];

  postPatch =
    let
      setup = replaceVars ./setup.py {
        inherit pname;
        desc = meta.description;
        version = builtins.replaceStrings [ "-" ] [ "." ] (lib.strings.removePrefix "0-unstable-" version);
      };
    in
    ''
      ln -s ${setup} setup.py

      substituteInPlace stuff/general.py \
        --replace-fail "os.path.dirname(__file__), \"..\", \"bin\"," "\"${resetprop}/share\","
    '';

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = with lib; {
    description = "Python Script to add libraries to waydroid";
    homepage = "https://github.com/casualsnek/waydroid_script";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ataraxiasjel ];
    mainProgram = "waydroid-script";
  };
}
