{ config, lib, pkgs, ... }:
{
	options.username = lib.mkOption {
		type = lib.types.str;
		description = "username to be passed to gui programs needing to e.g. add it to user groups etc.";
	};

	imports = [
		./1password
	];

	config = {
		# Default GUI applications
		environment.systemPackages = with pkgs; [
			obsidian
			localsend
		];
		# Setup 1Password
		programs.gui.onePassword.enable = true;
		programs.gui.onePassword.username = config.username;

		networking.firewall.allowedTCPPorts = [
			# localsend
			53317
		];
		networking.firewall.allowedUDPPorts = [
			# localsend
			53317
		];
	};
}
