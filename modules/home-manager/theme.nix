{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.theme.enable = lib.mkEnableOption "enables theme module";

  config = lib.mkIf config.modules.theme.enable {
    # 🍌
    home.pointerCursor = {
      enable = true;
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
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
