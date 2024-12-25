{ inputs, pkgs, config, lib, ... }:
{
	options = {
		grub.enable = lib.mkEnableOption "enables grub";
		grub.gfxmodeEfi = lib.mkOption { default = "auto"; type = lib.types.str; description = "grub gfxmodeEfi"; };
	};

	config = lib.mkIf config.grub.enable {
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.grub = {
			enable = true;
			efiSupport = true;
			useOSProber = true;
			device = "nodev";
			theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
			fontSize = 12;
			gfxmodeEfi = config.grub.gfxmodeEfi;
			extraEntries = ''
	  menuentry "Reboot" {
		  reboot
	  }
	  menuentry "Poweroff" {
		  halt
	  }
			'';
		};
	};
}
