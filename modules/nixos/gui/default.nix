{ config, lib, pkgs, ... }:
{
	options.programs.gui.username = lib.mkOption {
		type = lib.types.str;
		description = "username to be passed to gui programs needing to e.g. add it to user groups etc.";
	};

	imports = [
		./1password
		./ollama
		./steam
	];

	config = {
		# Default GUI applications
		environment.systemPackages = with pkgs; [
			obsidian
			localsend
			qdirstat
			vscode
			(google-chrome.override {
				commandLineArgs = [
					"--ozone-platform-hint=auto" # To allow to run natively on wayland
				];
			})
		];
		# Setup 1Password
		programs.gui.onePassword.enable = true;
		programs.gui.onePassword.username = config.programs.gui.username;

		# Localsend firewall rules
		networking.firewall.allowedTCPPorts = [ 53317 ];
		networking.firewall.allowedUDPPorts = [ 53317 ];
	};
}
