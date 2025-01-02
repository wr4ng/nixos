{ inputs, lib, pkgs, ... }:
{
	# Import home-manager modules
	imports = [
		inputs.self.homeManagerModules
		inputs.hyprpanel.homeManagerModules.hyprpanel
	];

	# Enable and configure modules
	kitty.enable = true;
	kitty.fontSize = 14;
	webcord.enable = true;
	nvim.enable = true;

	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "wr4ng";
	home.homeDirectory = "/home/wr4ng";

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Enable Nix flake support
	nix = {
		#package = pkgs.nix;
		settings.experimental-features = [ "nix-command" "flakes" ];
	};

	programs.hyprpanel = {
		enable = false;
		systemd.enable = true;
		hyprland.enable = true;
		overwrite.enable = true;
		#theme = "gruvbox_split";
		layout = {
			"bar.layouts" = {
				"0" = {
					left = [ "dashboard" "workspaces" ];
					middle = [ "media" ];
					right = [ "volume" "systray" "notifications" ];
				};
			};
		};
		settings = {
			bar.launcher.autoDetectIcon = true;
			bar.workspaces.show_icons = true;
			menus.clock = {
				time = {
					military = true;
					hideSeconds = true;
				};
				weather.unit = "metric";
			};
			menus.dashboard.directories.enabled = false;
			menus.dashboard.stats.enable_gpu = true;
			theme.bar.transparent = true;
			theme.font = {
				name = "Jetbrains Mono";
				size = "16px";
			};
		};
	};

	home.pointerCursor = lib.mkForce {
		gtk.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 20;
	};

	gtk = {
		enable = true;
		theme = {
			name = "WhiteSur-Dark";
			package = pkgs.whitesur-gtk-theme;
		};
		gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
		gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
	};

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};

	qt = {
		enable = true;
		style.name = "adwaita-dark";
		platformTheme.name = "adwaita";
	};

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.11"; # Please read the comment before changing.

	home.packages = with pkgs; [
		whitesur-gtk-theme
	];

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
