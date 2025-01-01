{ pkgs, lib, config, ... }:

{
	options.programs.gui.steam.enable = lib.mkEnableOption "enables steam";

	config = lib.mkIf config.programs.gui.steam.enable {
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
			STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${config.users.defaultUser}/.steam/root/compatibilitytools.d";
		};
	};
}
