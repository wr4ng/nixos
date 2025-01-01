{ config, lib, ... }:

{
	options.programs.gui.onePassword = {
		enable = lib.mkEnableOption "enables 1Password GUI application";
	};

	config = lib.mkIf config.programs.gui.onePassword.enable {
		programs._1password.enable = true;
		programs._1password-gui = {
			enable = true;
			polkitPolicyOwners = [ config.users.defaultUser ];
		};
	};
}
