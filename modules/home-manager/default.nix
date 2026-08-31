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

  modules.shell.enable = lib.mkDefault true;
  modules.kitty.enable = lib.mkDefault true;
  modules.zellij.enable = lib.mkDefault true;
  modules.neovim.enable = lib.mkDefault true;
}
