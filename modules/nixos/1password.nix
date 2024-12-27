{ config, lib, ... }:

{
	options.onePasswordGUI = {
		enable = lib.mkEnableOption "enables 1Password GUI application";
		username = lib.mkOption {
			type = lib.types.str;
			description = "The username for 1Password polkit policy. Defaults to the system's default user.";
		};
	};

	config = lib.mkIf config.onePasswordGUI.enable {
		programs._1password.enable = true;
		programs._1password-gui = {
			enable = true;
			polkitPolicyOwners = [ config.onePasswordGUI.username ];
		};

		# Add an assertion to ensure username is set
		assertions = [
			{
				assertion = config.onePasswordGUI.username != null;
				message = "You must specify a valid username for the 1Password GUI polkit policy.";
			}
		];
	};
}
