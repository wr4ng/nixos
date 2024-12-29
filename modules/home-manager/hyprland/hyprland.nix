{ pkgs, lib, config, inputs, ... }:
let
	wallpaperScript = pkgs.writeShellScript "set-random-wallpaper" ''
		#!/bin/bash
		WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
		WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
		swww img "$WALLPAPER"
	'';
in
	{
	imports = [
		./wlogout/wlogout.nix
		./waybar/waybar.nix
		./rofi/rofi.nix
	];

	options = {
		hyprland.enable = lib.mkEnableOption "enables hyprland configuration";
	};

	config = lib.mkIf config.hyprland.enable {
		home.packages = with pkgs; [
			#TODO: Should system be provided as input? "${system}" (config.hyprland.system or similar?)
			inputs.hyprland-qtutils.packages."x86_64-linux".default
			# Polkit agent
			# TODO: Move enabling polkit security into hyprland module (Need to make it a NixOS module that also does home-manager stuff. See main-user.nix)
			hyprpolkitagent
			# Clipboard support
			wl-clipboard
			# Background/Wallpaper
			swww
			# Network tray app
			# TODO: Load at startup in hyprland.conf
			networkmanagerapplet
			# Audio control
			pavucontrol
			pamixer
			# Screenshot wayland support + region selecting + editing
			grim
			slurp
			swappy
		];

		home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
		home.file.".config/swappy/config".source = ./swappy/config;

		# Wallpaper setup
		home.file."Pictures/wallpapers".source = ./../../../wallpapers;
		home.file.".config/set-random-wallpaper.sh".source = wallpaperScript;

		wlogout.enable = true;
		waybar.enable = true;
		rofi.enable = true;

		home.sessionVariables = {
			NIXOS_OZONE_WL = "1"; # Hint to election apps to use wayland
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
					text = cmd[update:1000] echo $(date +"%Y-%M-%d")
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
}
