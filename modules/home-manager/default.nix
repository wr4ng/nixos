{ lib, ... }: {
  imports = [ ./shell.nix ./kitty.nix ];

  module.shell.enable = lib.mkDefault true;
  module.kitty.enable = lib.mkDefault true;
}
