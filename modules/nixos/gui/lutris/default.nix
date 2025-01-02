{ pkgs, lib, config, ... }:

{
	options.programs.gui.lutris.enable = lib.mkEnableOption "enables lutris";

	config = lib.mkIf config.programs.gui.lutris.enable {
		environment.systemPackages = with pkgs; [ lutris ];
	};
}
