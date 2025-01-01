{ lib, config, pkgs, ... }:

{
	options.modules.android-studio.enable = lib.mkEnableOption "enable android-studio";

	config = lib.mkIf config.modules.android-studio.enable {
		environment.systemPackages = [
			pkgs.android-studio
		];

		programs.adb.enable = true;
		users.users.${config.users.defaultUser}.extraGroups = [
			"kvm" 		# enable hardware acceleration
			"adbusers" 	# enable adb
		];
	};
}
