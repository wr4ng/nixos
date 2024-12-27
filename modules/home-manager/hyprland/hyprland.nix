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
	};
}
