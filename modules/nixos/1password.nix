{ lib, config,  ... }:

with lib;

let cfg = config.module.onepassword;
in {

  options.module.onepassword = {
    enable = mkEnableOption "enable onepassword module";
    username = mkOption {
      type = types.str;
      default = "";
      description = "username to add to 'polkitPolicyOwners' for CLI and system auth to work";
    };
  };

  config = mkIf cfg.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "${cfg.username}" ];
    };
  };
}
