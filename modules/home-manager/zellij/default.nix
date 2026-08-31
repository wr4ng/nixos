{ lib, config, ... }: {

  options = {
    modules.zellij.enable = lib.mkEnableOption "enable zellij module";
  };

  config = lib.mkIf config.modules.zellij.enable {
    programs.zellij = {
      enable = true;
    };
    xdg.configFile."zellij".source = ./config;
  };
}
