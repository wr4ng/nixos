{ pkgs, lib, config, ... }:

{
	programs.zellij = {
		enable = true;
		enableZshIntegration = true;
	};
	home.file.".config/zellij".source = ./config;
}
