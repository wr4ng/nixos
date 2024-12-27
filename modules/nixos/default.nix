{
	imports = [
		# Setup main user
		./main-user/main-user.nix

		# Import modules (not enabled by default)
		./grub.nix
		./nvidia-drivers.nix
		./steam.nix
		./1password.nix
	];
}
