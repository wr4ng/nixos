{ lib, config,  ... }:

with lib;

let cfg = config.module.virt-manager;
in {

  options.module.virt-manager  = {
    enable = mkEnableOption "enable virt-manager  module";
    username = mkOption {
      type = types.str;
      default = "";
      description = "username to add to 'libvirtd' group";
    };
  };

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["${cfg.username}"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
