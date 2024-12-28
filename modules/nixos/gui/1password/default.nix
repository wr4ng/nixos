{ config, lib, ... }:

{
	options.programs.gui.onePassword = {
		enable = lib.mkEnableOption "enables 1Password GUI application";
		username = lib.mkOption {
			type = lib.types.str;
			description = "Username used for 1Password polkit policy";
		};
	};

	config = lib.mkIf config.programs.gui.onePassword.enable {
		programs._1password.enable = true;
		programs._1password-gui = {
			enable = true;
			polkitPolicyOwners = [ config.programs.gui.onePassword.username ];
		};

		# Add an assertion to ensure username is set
		assertions = [
			{
				assertion = config.programs.gui.onePassword.username != null;
				message = "You must specify a valid username for the 1Password GUI polkit policy.";
			}
		];
	};
}
