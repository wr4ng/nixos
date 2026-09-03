{ lib, config, ... }:

with lib;

let
  cfg = config.modules.qmk;
in
{

  options.modules.qmk.enable = mkEnableOption "enable qmk module";

  config = mkIf cfg.enable {
    hardware.keyboard.qmk = {
      enable = true;
      keychronSupport = true;
    };

    services.udev.packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial
    ];

    environment.systemPackages = with pkgs; [
      qmk
      via
      vial
    ];
  };
}
