{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.steam;
in
{

  options.modules.steam = {
    enable = mkEnableOption "enable steam module";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
    ];
  };
}
