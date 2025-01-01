{ lib, ... }:

{
	imports = [
		# Setup main user
		./main-user

		# Import nixos modules
		./grub.nix
		./nvidia-drivers.nix
		./gnome-keyring.nix
		./hyprland

		# Import default gui programs
		./gui
	];

	options = {
		users.defaultUser = lib.mkOption {
			type = lib.types.str;
			default = "wr4ng"; #TODO: Maybe set somewhere else instead of using default value?
		};
	};

	config = {
		#TODO: Move this to some module
		# Enable running non-nix binaries. See https://nix.dev/guides/faq.html#how-to-run-non-nix-executables
		programs.nix-ld.enable = true;
		programs.nix-ld.libraries = [
			# Add any missing dynamic libraries for unpackaged programs
			# here, NOT in environment.systemPackages
		];
	};
}
