{ inputs, pkgs, lib, config, ... }:

{
	imports = [
		./wlogout/wlogout.nix
		./waybar/waybar.nix
		./rofi/rofi.nix
	];

	options = {
		hyprland.enable = lib.mkEnableOption "enables hyprland configuration";
	};

	config = lib.mkIf config.hyprland.enable {
		home.packages = with pkgs; [
			inputs.hyprland-qtutils.packages."${system}".default
			hyprpolkitagent
			wl-clipboard
			swww
			# screenshots
			grim
			slurp
			swappy
		];

		home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
		home.file.".config/swappy/config".source = ./swappy/config;

		wlogout.enable = true;
		waybar.enable = true;
		rofi.enable = true;

		home.sessionVariables = {
			NIXOS_OZONE_WL = "1"; # Hint to election apps to use wayland
		};
	};
}
