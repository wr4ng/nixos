{ lib, config, ... }: {

  options = { module.zellij.enable = lib.mkEnableOption "enable zellij module"; };

  config = lib.mkIf config.module.zellij.enable {
    programs.zellij = {
      enable = true;
    };
    xdg.configFile."zellij".source = ./config;
  };
}
