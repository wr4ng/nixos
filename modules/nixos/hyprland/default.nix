{ inputs, pkgs, lib, config, ... }:

{
	imports = [
		inputs.home-manager.nixosModules.default
	];

	options = {
		modules.hyprland.enable = lib.mkEnableOption "enables my hyprland module";
		modules.hyprland.waybar.backlight.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "enables backlight waybar module";
		};
	};

	config = lib.mkIf config.modules.hyprland.enable {
		# Enable hyprland.
		programs.hyprland.enable = true;
		programs.hyprland.xwayland.enable = true;

		# Enable polkit
		security.polkit.enable = true;

		# Allow hyprlock to unlock session
		security.pam.services.hyprlock = {}; 

		# Home-manager module
		home-manager.users.${config.users.defaultUser} = {pkgs, ...}: {
			# Import hyprland home-manager module
			imports = [
				inputs.hyprland.homeManagerModules.default
				./rofi/rofi.nix
				./waybar/waybar.nix
				./wlogout/wlogout.nix
			];
			# Setup packages needed for hyprland
			home.packages = with pkgs; [
				#TODO: Should system be provided as input? "${system}" (config.hyprland.system or similar?)
				inputs.hyprland-qtutils.packages."x86_64-linux".default
				# Polkit agent
				hyprpolkitagent
				# Clipboard support
				wl-clipboard
				cliphist
				# Background/Wallpaper
				swww
				# Network tray app
				networkmanagerapplet
				# Audio control
				pavucontrol
				pamixer
				# Screenshot wayland support + region selecting + editing
				grim
				slurp
				swappy
				# Color picker
				hyprpicker
				# Notifications
				libnotify
				mako
				# Audio control
				playerctl
			];

			# Use hyprland home-manager module to set hyprbars plugin (linked to nix-store)
			wayland.windowManager.hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.system}.hyprland; # Make sure package follows flake input
				plugins = [
					inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
				];
				settings = {
					plugin = {
						hyprbars = {
							bar_color = "rgba(1E1E2FFF)";
							bar_height = 24;
							bar_button_padding = 10;
							bar_text_size = 10;
							bar_text_font = "JetBrainsMono Nerd Font Bold";
							"col.text" = "rgba(bd93f9ff)";
							bar_part_of_window = true;
							bar_precedence_over_border = true;

							# hyprbars-button = color, size, on-click
							hyprbars-button = [
								"rgba(ff4040f0), 10, , hyprctl dispatch killactive       # Close button"
								"rgba(40ff40f0), 10, 󰊓, hyprctl dispatch fullscreen 0     # Fullscreen button"
							];
						};
					};
				};
				# Remaining config is in hyprland.conf
				extraConfig = builtins.readFile ./hyprland.conf;
			};

			home.file.".config/swappy/config".source = ./swappy/config;

			# Wallpaper setup
			home.file."Pictures/wallpapers".source = ./../../../wallpapers;
			# Wallpaper script to set a random wallpaper from ~/Pictures/wallpapers/
			home.file.".config/set-random-wallpaper.sh".source = pkgs.writeShellScript "set-random-wallpaper" ''
				#!/bin/bash
				WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
				WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
				swww img "$WALLPAPER"
			'';

			wlogout.enable = true;
			waybar.enable = true;
			waybar.backlight.enable = config.modules.hyprland.waybar.backlight.enable;
			rofi.enable = true;

			home.sessionVariables = {
				NIXOS_OZONE_WL = "1"; # Hint to election apps to use wayland
			};

			# Enable mako for notifications
			services.mako = {
				enable = true;
				actions = true;
				borderRadius = 8;
				borderSize = 1;
				defaultTimeout = 10000;
				icons = true;
				layer = "overlay";
				maxVisible = 3;
				padding = "10";
				width = 300;
				font = "monospace 12";
				# Theming (https://github.com/catppuccin/mako/blob/main/themes/catppuccin-macchiato/catppuccin-macchiato-lavender)
				backgroundColor = "#24273a";
				textColor = "#cad3f5";
				borderColor = "#b7bdf8";
				progressColor = "over #363a4f";
			};

			#TODO: Move to submodule
			programs.hyprlock = {
				enable = true;
				extraConfig = ''
				# GENERAL
				general {
					no_fade_in = false
					grace = 0
					disable_loading_bar = true
				}

				background {
					monitor =
					path = /home/wr4ng/Pictures/wallpapers/world.webp
					color = rgba(25, 20, 20, 1.0)

					# all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
					blur_passes = 1 # 0 disables blurring
					blur_size = 5
					noise = 0.0117
					contrast = 0.8916
					brightness = 0.8172
					vibrancy = 0.1696
					vibrancy_darkness = 0.0
				}

				input-field {
					monitor =
					size = 250, 60
					outline_thickness = 2
					dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
					dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
					dots_center = true
					outer_color = rgba(0, 0, 0, 0)
					inner_color = rgba(0, 0, 0, 0.75)
					font_color = rgb(200, 200, 200)
					fade_on_empty = false
					font_family = "Hack Nerd Font Mono"
					placeholder_text = <span foreground="##cdd6f4"></span>
					hide_input = false
					position = 0, -120
					halign = center
					valign = center
				}

				# TIME
				label {
					monitor =
					# text = cmd[update:1000] echo "$(date +"%-I:%M%p")"
					text = $TIME
					color = rgba(255, 255, 255, 0.8)
					font_size = 100
					font_family = "Hack Nerd Font Mono"
					position = 0, -300
					halign = center
					valign = top
				}

				# DATE
				label {
					monitor =
					text = cmd[update:1000] echo $(date +"%Y-%m-%d")
					color = rgba(255, 255, 255, 0.8)
					font_size = 20
					font_family = "Hack Nerd Font Mono"
					position = 0, -450
					halign = center
					valign = top
				}

				# USER
				label {
					monitor =
					text = $USER
					color = rgba(255, 255, 255, 0.8)
					font_size = 20
					font_family = "Hack Nerd Font Mono Bold"
					position = 0, -60
					halign = center
					valign = center
				}
				'';
			};
		};
	};
}
