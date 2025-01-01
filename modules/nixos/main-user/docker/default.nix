{ config, pkgs, ... }:
{
	# Enable docker
	virtualisation.docker.enable = true;

	# Add user to docker usergroup
	users.extraGroups.docker.members = [ config.users.defaultUser ];

	environment.systemPackages = with pkgs; [
		docker-compose
		lazydocker
	];
}
