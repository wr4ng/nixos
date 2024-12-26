{ pkgs, lib, config, ... }:

{
	options = {
		nvim.enable = lib.mkEnableOption "enables nvim";
	};

	config = lib.mkIf config.nvim.enable {
		home.packages = with pkgs; [
			neovim
		];

		home.sessionVariables = {
			EDITOR = "nvim";
		};

		# Symlink config to ~/.config/nvim/
		home.file.".config/nvim".source = ./config;
	};
}
