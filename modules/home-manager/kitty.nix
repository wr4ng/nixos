{ pkgs, lib, config, ... }:

{
	options = {
		kitty = {
			enable = lib.mkEnableOption "enables kitty + configuration";
			fontSize = lib.mkOption {
				default = 12;
				type = lib.types.int;
				description = "kitty font size";
			};
		};

	};

	config = lib.mkIf config.kitty.enable {
		programs.kitty = {
			enable = true;
			font = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrainsMono Nerd Font Mono";
				size = config.kitty.fontSize;
			};
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


				tab_bar_edge = "bottom";
				tab_bar_style = "powerline";
				tab_bar_align = "left";
				tab_bar_min_tabs = "2";
				tab_powerline_style = "round";
			};
			themeFile = "Catppuccin-Mocha";
		};
	};

}
