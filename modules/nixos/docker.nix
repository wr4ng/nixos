{ lib, config,  ... }:

with lib;

let cfg = config.module.docker;
in {

  options.module.docker = {
    enable = mkEnableOption "enable docker module";
    username = mkOption {
      type = types.str;
      default = "";
      description = "username of user added to 'docker' group";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
		users.users.${cfg.username}.extraGroups = [ "docker" ];
  };
}
