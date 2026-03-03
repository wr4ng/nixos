{ lib, ... }: {
  imports = [
    ./shell.nix
    ./kitty.nix
    ./helix.nix
    ./zellij
    ./neovim
  ];

  module.shell.enable = lib.mkDefault true;
  module.kitty.enable = lib.mkDefault true;
  # module.helix.enable = lib.mkDefault true;
  module.zellij.enable = lib.mkDefault true;
  module.neovim.enable = lib.mkDefault true;
}
