{ inputs, config, pkgs, ... }:

{
  imports = [ inputs.self.outputs.homeManagerModules.default ];

  home.username = "wr4ng";
  home.homeDirectory = "/home/wr4ng";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    google-chrome
    gh
    vscode
    obsidian
    discord
    pinta
    orca-slicer
    # TODO: Move to some Gnome config module
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    # TODO: Move to shell module
    lazygit
    tree
    ripgrep
    fd
    zip
    unzip
    file
    # TODO: Move to kitty module
    nerd-fonts.jetbrains-mono
  ];

  # Set GNOME settings + keybindings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };
    "org/gnome/desktop/wm/keybindings" = { close = [ "<Super>q" ]; };
    "org/gnome/settings-daemon/plugins/media-keys" = { www = [ "<Super>w" ]; };
    # Make Alt+Tab switch through all open windows instead of applications
    "org/gnome/desktop/wm/keybindings" = {
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };
    # Add custom binding for terminal
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        name = "Open Terminal";
        command = "kitty";
        binding = "<Super>Return";
      };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        dash-to-dock.extensionUuid
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "kitty.desktop"
        "google-chrome.desktop"
        "obsidian.desktop"
        "code.desktop"
      ];
    };
    # Disable default dash-to-dock "Show dock" shortcut (conflicting with close window)
    "org/gnome/shell/extensions/dash-to-dock" = {
        shortcut = [];
    };
  };

  home.pointerCursor = {
    name = "Banana";
    size = 32;
    package = pkgs.banana-cursor;
    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Banana";
      size = 32;
      package = pkgs.banana-cursor;
    };
  };

  # Symlink config to ~/.config/nvim/
  # using mkOutOfStoreSymlink to link the folder directly instead of using the nix store
  # Allows neovim to update lazy-lock.json
  # home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
  #  "${config.home.homeDirectory}/nixos/modules/home-manager/nvim/config";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
