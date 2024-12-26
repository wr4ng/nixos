{ inputs, lib, pkgs, ... }:
{
	imports = [
		inputs.self.homeManagerModules.kitty
		inputs.self.homeManagerModules.hyprland
		inputs.self.homeManagerModules.webcord
		inputs.self.homeManagerModules.nvim
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

	nixpkgs.config.allowUnfree = true;

	programs.zoxide.enable = true;
	programs.lazygit.enable = true;

	programs.git = {
		enable = true;
		userName = "Mads Christian Wrang Nielsen";
		userEmail = "madscwn@gmail.com";
	};


	programs.gh.enable = true;

	home.pointerCursor = lib.mkForce {
		gtk.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 20;
	};

	gtk = {
		enable = true;
		theme = {
			name = "Dracula";
			package = pkgs.dracula-theme;
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
		style.name = "adwaita-dar";
		style.package = pkgs.adwaita-qt;
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			ls="eza --icons --group-directories-first --sort type --color=always";
			open="xdg-open";
		};
		history.size = 10000;
		oh-my-zsh = {
			enable = true;
			plugins = [
				"git"
				"golang"
				"rust"
				"python"
				"gh"
				"sudo"
				"command-not-found"
			];
		};
		# Enable fzf zsh integration and powerlevel10k.
		initExtra = ''
	  eval "$(fzf --zsh)"
	  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
	  source ~/.p10k.zsh
		'';
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
		zsh-powerlevel10k
		fzf
		ripgrep
		(google-chrome.override {
			commandLineArgs = [
				"--ozone-platform-hint=auto"
				"--disable-gpu"
			];
		})
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
	};


	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
