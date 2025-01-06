{ pkgs, lib, config, ... }:

{
	options = {
		nvim.enable = lib.mkEnableOption "enables nvim";
	};

	config = lib.mkIf config.nvim.enable {
		home.packages = with pkgs; [
			neovim
			# using lua 5.1 since image.nvim requires magick installed by luarocks which hasn't been updated for lua 5.2 yet
			lua5_1
			luarocks
			python3Packages.pip
			rust-analyzer
		];

		home.sessionVariables = {
			EDITOR = "nvim";
		};

		# Symlink config to ~/.config/nvim/
		# using mkOutOfStoreSymlink to link the folder directly instead of using the nix store
		# Allows neovim to update lazy-lock.json
		home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home-manager/nvim/config";
	};
}
