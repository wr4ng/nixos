{ inputs, config, pkgs, ... }:

{
  imports = [ inputs.self.outputs.homeManagerModules.default ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    google-chrome
    gh
    python3
    lazygit
    nerd-fonts.jetbrains-mono
    vscode
    obsidian
    discord
    tree
    ripgrep
    fd
    zip
    unzip
    gcc
    file
    rustup
    uv
    pnpm
    nodejs
    bruno
    typst
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    whatsapp-electron
    pinta
    blender
  ];

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ lua-language-server ];
  };

  fonts.fontconfig.enable = true;

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wr4ng/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "nvim"; };

  # Symlink config to ~/.config/nvim/
  # using mkOutOfStoreSymlink to link the folder directly instead of using the nix store
  # Allows neovim to update lazy-lock.json
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos/modules/home-manager/nvim/config";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
