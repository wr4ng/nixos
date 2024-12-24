{ inputs, lib, pkgs, ... }:
{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "wr4ng";
	home.homeDirectory = "/home/wr4ng";

	programs.zoxide.enable = true;

	nixpkgs.config.allowUnfree = true;

	programs.git = {
		enable = true;
		userName = "Mads Christian Wrang Nielsen";
		userEmail = "madscwn@gmail.com";
	};

	programs.gh.enable = true;

	imports = [
		inputs.self.homeManagerModules.kitty
		inputs.self.homeManagerModules.webcord
	];

	kitty.enable = true;
	kitty.fontSize = 14;

	webcord.enable = true;

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
		gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
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
				"--enable-features=UseOzonePlatform"
				"--ozone-platform=wayland"
			];
		})

		inputs.hyprland-qtutils.packages."${pkgs.system}".default
		# # It is sometimes useful to fine-tune packages, for example, by applying
		# # overrides. You can do that directly here, just don't forget the
		# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
		# # fonts?
		# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

		# # You can also create simple shell scripts directly inside your
		# # configuration. For example, this adds a command 'my-hello' to your
		# # environment:
		# (pkgs.writeShellScriptBin "my-hello" ''
		#   echo "Hello, ${config.home.username}!"
		# '')
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/wr4ng/etc/profile.d/hm-session-vars.sh
	#
	home.sessionVariables = {
		EDITOR = "nvim";
		#HYPRCURSOR_THEME = "Bibata-Modern-Classic";
		#HYPRCURSOR_SIZE = 20;
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
