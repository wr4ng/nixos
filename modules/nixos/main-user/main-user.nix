{ pkgs, ... }:

let
	username = "wr4ng";
in
{
	users.users.${username} = {
		isNormalUser = true;
		description = "Mads Christian Wrang Nielsen";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
			vim
			wget
			killall
			htop
			tree
			fzf
			git
			unzip
			eza
			gcc
			go
			cargo
			tealdeer
			cbonsai
			fastfetch
		];
	};

	# Enable zsh for login shell
	programs.zsh.enable = true;

	programs.noisetorch.enable = true;

	# Configure zsh using home-manager
	home-manager.users.${username} = {
		# Install powerlevel10k
		home.packages = with pkgs; [
			zsh-powerlevel10k
		];

		# Setup zsh
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
			initExtra = ''
				# Enable fzf integration (for history Ctrl+R)
				eval "$(fzf --zsh)"
				# Initialize powerlevel10k
				source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
				source ~/.p10k.zsh
			'';
		};
		# Symlink powerlevel10k config
		home.file = {
			".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
		};
	};
}
