{ inputs, lib, pkgs, ... }:
{
	# Import home-manager modules
	imports = [
		inputs.self.homeManagerModules
		inputs.hyprpanel.homeManagerModules.hyprpanel
	];

	# Enable and configure modules
	hyprland.enable = true;
	waybar.backlight.enable = false; # No backlight on desktop
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

	programs.zoxide.enable = true;
	programs.lazygit.enable = true;

	services.mako = {
		enable = true;
		#catppuccin.enable = true;
		actions = true;
		#anchor = if hostname == "kara" then "top-center" else "top-right";
		borderRadius = 8;
		borderSize = 1;
		defaultTimeout = 10000;
		icons = true;
		layer = "overlay";
		maxVisible = 3;
		padding = "10";
		width = 300;
	};

	programs.git = {
		enable = true;
		userName = "Mads Christian Wrang Nielsen";
		userEmail = "madscwn@gmail.com";
	};

	programs.gh.enable = true;
	services.gnome-keyring.enable = true;

	programs.hyprpanel = {
		enable = true;
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

	home.pointerCursor = lib.mkForce {
		gtk.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 20;
	};

	gtk = {
		enable = true;
		theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
		};
		#theme = {
		#	name = "Dracula";
		#	package = pkgs.dracula-theme;
		#};
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

	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		google-chrome
		libnotify
		vscode
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
	};


	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
