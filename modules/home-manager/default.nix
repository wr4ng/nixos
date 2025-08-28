{ pkgs, lib, ... }: {
  imports = [
    ./shell.nix
  ];

  module.shell.enable = lib.mkDefault true;
}
