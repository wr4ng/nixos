{ pkgs, lib, config, ... }:

{
	options = {
		rofi.enable = lib.mkEnableOption "enables rofi";
	};

	config = lib.mkIf config.rofi.enable {
		home.packages = with pkgs; [
			rofi-wayland
		];

		home.file.".config/rofi/config.rasi".source = ./config.rasi;
		home.file.".config/rofi/themes".source = ./themes;
	};
}
