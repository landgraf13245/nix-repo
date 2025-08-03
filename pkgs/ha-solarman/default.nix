{
  buildHomeAssistantComponent,
  fetchFromGitHub,
  lib,
	propcache,
	aiohttp,
	aiofiles,
	pyyaml,
}:

buildHomeAssistantComponent rec {
  owner = "davidrapan";
  domain = "solarman";
  version = "v25.06.07";

  src = fetchFromGitHub {
    owner = "davidrapan";
    repo = "ha-solarman";
    tag = version;
    hash = "sha256-fUlM1AecyYbwm9J9Ip72gg09LqA/I5JV5PQJmMadr8c=";
  };

  dependencies = [
		propcache
		aiohttp
		aiofiles
    pyyaml
  ];

  meta = {
    description = "Solarman Stick Logger integration for Home Assistant";
    homepage = "https://github.com/davidrapan/ha-solarman";
    maintainers = with lib.maintainers; [ lukas ];
    license = lib.licenses.mit;
  };
}
