{ inputs, pkgs, config, lib, ... }:
{
	options = {
		grub.enable = lib.mkEnableOption "enables grub";
		grub.gfxmodeEfi = lib.mkOption {
			default = "auto";
			type = lib.types.str;
			description = "grub gfxmodeEfi";
		};
		grub.useOSProber = lib.mkOption {
			default = false;
			type = lib.types.bool;
			description = "enables os-prober on nixos-rebuild switch";
		};
	};

	config = lib.mkIf config.grub.enable {
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.grub = {
			enable = true;
			efiSupport = true;
			useOSProber = config.grub.useOSProber;
			devices = [ "nodev" ];
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
