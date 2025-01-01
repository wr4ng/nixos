{ pkgs, ... }:

{
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

		# Localsend firewall rules
		networking.firewall.allowedTCPPorts = [ 53317 ];
		networking.firewall.allowedUDPPorts = [ 53317 ];

		# KDE Connect
		programs.kdeconnect.enable = true;
	};
}
