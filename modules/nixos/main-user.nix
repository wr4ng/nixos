{ pkgs, ... }:
{
	users.users.wr4ng = {
		isNormalUser = true;
		description = "Mads Christian Wrang Nielsen";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};
}
