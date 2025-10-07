{ lib, ... }: {
  imports = [ ./shell.nix ./kitty.nix ./helix.nix ./zellij ];

  module.shell.enable = lib.mkDefault true;
  module.kitty.enable = lib.mkDefault true;
  module.helix.enable = lib.mkDefault true;
  module.zellij.enable = lib.mkDefault true;
}
