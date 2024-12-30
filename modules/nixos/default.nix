{ inputs, pkgs, config, lib, ... }:

{
	imports = [
		# Setup main user
		./main-user/main-user.nix

		# Import modules (not enabled by default)
		./grub.nix
		./nvidia-drivers.nix
		./gnome-keyring.nix
		./hyprland

		# Import default gui programs
		./gui
	];

	# Set username used by GUI programs
	#TODO: Set using main-user.nix or similar
	programs.gui.username = "wr4ng";

	# Enable running non-nix binaries. See https://nix.dev/guides/faq.html#how-to-run-non-nix-executables
	  programs.nix-ld.enable = true;
	  programs.nix-ld.libraries = with pkgs; [
		# Add any missing dynamic libraries for unpackaged programs
		# here, NOT in environment.systemPackages
	  ];
}
