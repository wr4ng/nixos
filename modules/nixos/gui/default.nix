{ config, lib, ... }:
{
	options.username = lib.mkOption {
		type = lib.types.str;
		description = "username to be passed to gui programs needing to e.g. add it to user groups etc.";
	};

	imports = [
		./1password
	];

	config = {
		programs.gui.onePassword.enable = true;
		programs.gui.onePassword.username = config.username;
	};
}
