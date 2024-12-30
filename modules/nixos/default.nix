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
}
