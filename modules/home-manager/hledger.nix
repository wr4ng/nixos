{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.module.hledger.enable = lib.mkEnableOption "enables hledger module";

  config = lib.mkIf config.module.hledger.enable {
    home.packages = with pkgs; [
      hledger
      hledger-web
    ];

    home.sessionVariables = {
      LEDGER_FILE = "~/finances/main.journal";
    };

  };
}
