{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.dtu.program-verification;
in
{

  options.modules.dtu.program-verification = {
    enable = mkEnableOption "enable 02245 Program Verification module";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      z3
    ];

    programs.nix-ld.libraries = with pkgs; [
      zlib
      stdenv.cc.cc
      # For getting Viper VSCode extension to work
      icu
      z3
    ];
  };
}
