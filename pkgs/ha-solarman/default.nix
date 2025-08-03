{
  buildHomeAssistantComponent,
  fetchFromGitHub,
  lib,
  pysolarmanv5,
  pyyaml,
}:

buildHomeAssistantComponent rec {
  owner = "StephanJoubert";
  domain = "solarman";
  version = "v25.06.07";

  src = fetchFromGitHub {
    owner = "davidrapan";
    repo = "ha-solarman";
    tag = version;
    hash = "sha256-+znRq7LGIxbxMEypIRqbIMgV8H4OyiOakmExx1aHEl8=";
  };

  dependencies = [
    pysolarmanv5
    pyyaml
  ];

  meta = {
    description = "Solarman Stick Logger integration for Home Assistant";
    homepage = "https://github.com/davidrapan/ha-solarman";
    maintainers = with lib.maintainers; [ lukas ];
    license = lib.licenses.mit;
  };
}
