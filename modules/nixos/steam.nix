{ pkgs, lib, config, ... }:

{
	options = {
		steam = {
			enable = lib.mkEnableOption "enables steam";
		};

	};

	config = lib.mkIf config.steam.enable {
		# Install Steam.
		programs.steam.enable = true;
		programs.steam.gamescopeSession.enable = true;
		programs.gamemode.enable = true;

		environment.systemPackages = with pkgs; [
			mangohud
			protonup
		];

		# Setup protonGE path.
		environment.sessionVariables = {
			STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/wr4ng/.steam/root/compatibilitytools.d";
		};
	};
}
