{ lib, config, ... }:

{
	options.modules.virt-manager.enable = lib.mkEnableOption "enable virt-manager";

	config = lib.mkIf config.modules.virt-manager.enable {
		# See https://nixos.wiki/wiki/Virt-manager
		programs.virt-manager.enable = true;
		virtualisation.libvirtd.enable = true;
		virtualisation.spiceUSBRedirection.enable = true;
		#TODO: Does the following two lines not do the same thing?
		users.groups.libvirtd.members = [ config.users.defaultUser ];
		users.users.${config.users.defaultUser}.extraGroups = [ "libvirtd" ];

		home-manager.users.${config.users.defaultUser} = { ... }: {
			dconf.settings = {
				"org/virt-manager/virt-manager/connections" = {
					autoconnect = ["qemu:///system"];
					uris = ["qemu:///system"];
				};
			};
		};
	};
}
