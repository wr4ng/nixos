{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.hledger.enable = lib.mkEnableOption "enables hledger module";

  config = lib.mkIf config.modules.hledger.enable {
    home.packages = with pkgs; [
      hledger
      hledger-web
    ];

    home.sessionVariables = {
      LEDGER_FILE = "~/finances/main.journal";
    };

  };
}
