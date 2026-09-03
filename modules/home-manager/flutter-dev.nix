{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.flutter-dev.enable = lib.mkEnableOption "enables flutter development module";

  config = lib.mkIf config.modules.flutter-dev.enable {
    home.packages = with pkgs; [
      flutter
      android-studio
    ];
  };
}
