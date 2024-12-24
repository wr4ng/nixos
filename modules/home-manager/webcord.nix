{ pkgs, lib, config, ... }:

{
	options = {
		webcord.enable = lib.mkEnableOption "enables webcord";
	};

	config = lib.mkIf config.webcord.enable {
		home.packages = with pkgs; [
			webcord
		];
	};
}
