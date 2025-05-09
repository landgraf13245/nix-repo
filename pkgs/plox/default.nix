{ lib, rustPlatform, fetchFromGitHub, openssl, libxkbcommon, wayland, pkg-config}:

rustPlatform.buildRustPackage rec {
  pname = "plox";
  version = "0.5.0";

  src = fetchFromGitHub {
		owner = "rfuzzo";
		repo = "plox";
		rev = "v${version}";
    sha256 = "sha256-9JkbeiaMJl1EIqz/YctfJkzcWm+701C/3E8Q/UHml8Y=";
  };
	cargoHash = "sha256-cbMoJM3528guWLw2IPPfEYxRSF5Yg7bJ4nHB5yCjPDo=";
	useFetchCargoVendor = true;
	
	nativeBuildInputs = [pkg-config];
  buildInputs = [
		libxkbcommon
		openssl
		wayland
	];

  meta = with lib; {
    description = "A small app to sort a modlist topologically according to ordering rules";
    homepage = "https://github.com/rfuzzo/plox";
    license = licenses.mit;
    platforms = ["x86_64-linux"];
  };
}


