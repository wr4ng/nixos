{ lib, ... }:
{
  imports = [
    ./shell.nix
    ./kitty.nix
    ./zellij
    ./neovim
    ./hledger.nix
    ./flutter-dev.nix
    ./theme.nix
    ./desktop.nix
  ];

  modules.shell.enable = lib.mkDefault true;
  modules.theme.enable = lib.mkDefault true;
  modules.kitty.enable = lib.mkDefault true;
  modules.neovim.enable = lib.mkDefault true;
  modules.desktop.enable = lib.mkDefault true;
}
