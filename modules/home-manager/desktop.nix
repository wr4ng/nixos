{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.desktop.enable = lib.mkEnableOption "enables desktop module";

  config = lib.mkIf config.modules.desktop.enable {
    home.packages = with pkgs; [
      # Gnome extensions
      gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.dash-to-panel
    ];

    # GNOME settings
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        show-battery-percentage = true;
      };
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        www = [ "<Super>w" ];
        home = [ "<Super>e" ];
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Open Terminal";
        command = "kitty";
        binding = "<Super>Return";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          # dash-to-dock.extensionUuid
          dash-to-panel.extensionUuid
        ];
      };
      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [ "<Shift><Super>s" ];
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        shortcut = [ ];
      };
    };
  };
}
