{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.flutter-dev.enable = lib.mkEnableOption "enables flutter development module";

  config = lib.mkIf config.modules.hledger.enable {
    home.packages = with pkgs; [
      flutter
      android-studio
    ];
  };
}
