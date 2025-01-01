{ lib, config, ... }:

{
	options.modules.bluetooth.enable = lib.mkEnableOption "enable bluetooth module";

	config = lib.mkIf config.modules.bluetooth.enable {
		hardware.bluetooth.enable = true; # enables support for Bluetooth
		hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

		services.blueman.enable = true; # enable blueman to use blueman-applet and blueman-manager to pair devices

		hardware.bluetooth.settings.General.Experimental = true; # needed to see battery of bluetooth devices (experimental)


		home-manager.users.${config.users.defaultUser} = { ... }: {
			services.mpris-proxy.enable = true; # enable mpris-proxy to allow bluetooth devices to control media players
		};
	};
}
