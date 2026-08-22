{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.module.flutter-dev.enable = lib.mkEnableOption "enables flutter development module";

  config = lib.mkIf config.module.hledger.enable {
    home.packages = with pkgs; [
      flutter
	  android-studio
    ];
  };
}
