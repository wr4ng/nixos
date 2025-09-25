{ pkgs, lib, config, ... }: {

  options = { module.kitty.enable = lib.mkEnableOption "enable kitty module"; };

  config = lib.mkIf config.module.kitty.enable {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration.enableZshIntegration = true;
      themeFile = "Catppuccin-Macchiato";
      font.package = pkgs.nerd-fonts.jetbrains-mono;
      font.name = "JetBrainsMono Nerd Font Mono";
      font.size = 14;
      settings = {
        enable_audio_bell = false;
        open_url_with = "default";
        detect_urls = "yes";
        show_hyperlink_targets = true;
        underline_hyperlinks = "hover";
        copy_on_select = "clipboard";

        input_delay = 2;
        sync_to_monitor = true;

        remember_window_size = true;
        draw_minimal_borders = true;
        window_margin_width = 4;
        hide_window_decorations = false;

        # Tab bar settings
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_bar_align = "left";
        tab_bar_min_tabs = "2";
        tab_powerline_style = "round";
      };
    };
  };
}
