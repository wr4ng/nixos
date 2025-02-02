{ inputs, lib, pkgs, ... }:
{
	imports = [
		inputs.self.homeManagerModules
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

	nixpkgs.config.allowUnfree = true;

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

	home.packages = with pkgs; [
		whitesur-gtk-theme
		kdePackages.qt6ct
	];

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.11"; # Please read the comment before changing.

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
