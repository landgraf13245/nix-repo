{
	stdenv,
	fetchFromGitHub,
	linuxPackages,
	kernel ? linuxPackages.kernel
}: 
stdenv.mkDerivation {
	name = "i915-sriov-dkms";
	src = fetchFromGitHub {
		owner = "strongtz";
		repo = "i915-sriov-dkms";
		tag = "2025.03.27";
		sha256 = "sha256-KDEFKa7bgDsm/GCvYDFObNDoZn2c71oaQlgYMAN2B0I=";
	};

	hardeningDisable = [ "pic" ];

	nativeBuildInputs = kernel.moduleBuildDependencies;

	makeFlags = [
		"KVERSION=${kernel.modDirVersion}"                                 # 3
		"KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"    # 4
		"INSTALL_MOD_PATH=$(out)"                                               # 5
	];
	buildFlags = [
		"KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"    # 4
	];
	buildPhase = ''
		make -j8 -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
  '';
	installPhase = ''
		install -D i915.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/gpu/drm/i915/i915.ko
  '';
}
