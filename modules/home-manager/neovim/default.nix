{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.module.neovim.enable = lib.mkEnableOption "enables neovim";

  config = lib.mkIf config.module.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
		nodejs_25
      ];
    };

    home.packages = with pkgs; [
      lua5_1
      luarocks
      python3Packages.pip
      tree-sitter
    ];

    # Symlink config to ~/.config/nvim/
    # using mkOutOfStoreSymlink to link the folder directly instead of using the nix store
    # Allows neovim to update lazy-lock.json, and to modify the neovim config without doing nixos-rebuild switch every time
    home.file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home-manager/neovim/config";
  };
}
