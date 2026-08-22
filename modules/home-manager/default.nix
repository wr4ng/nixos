{ lib, ... }:
{
  imports = [
    ./shell.nix
    ./kitty.nix
    ./zellij
    ./neovim
    ./hledger.nix
	./flutter-dev.nix
  ];

  module.shell.enable = lib.mkDefault true;
  module.kitty.enable = lib.mkDefault true;
  module.zellij.enable = lib.mkDefault true;
  module.neovim.enable = lib.mkDefault true;
}
