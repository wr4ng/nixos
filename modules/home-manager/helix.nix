{ pkgs, lib, config, ... }: {

  options = { module.helix.enable = lib.mkEnableOption "enable helix module"; };

  config = lib.mkIf config.module.helix.enable {
    programs.helix = {
      enable = true;
      settings.theme = "catppuccin_macchiato";
    };

    home.packages = with pkgs; [ wl-clipboard ];
  };
}
