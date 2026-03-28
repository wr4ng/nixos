{ lib, config, ... }: {

  options = { module.shell.enable = lib.mkEnableOption "enable shell module"; };

  config = lib.mkIf config.module.shell.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cd = "z";
        open = "xdg-open";
      };
      initContent = ''
				zstyle ':completion:*' menu select
				zstyle ':completion:*' special-dirs true
				zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        source <(just --completions zsh)
      '';
    };

		programs.starship = {
			enable = true;
			enableZshIntegration = true;
			settings = {
      	add_newline = false;
      	format = ''($nix_shell)$username$hostname( $shlvl)( $directory)( $git_branch$git_commit$git_state$git_status)( $cmd_duration)( $character)'';
      	username = {
      	  format = "[$user]($style)";
					style_user = "bold cyan";
      	  show_always = true;
      	};
      	hostname = {
      	  format = "[@$hostname]($style)";
      	  style = "bold red";
      	  ssh_only = false;
      	};
      	directory = {
      	  format = "[$path]($style)( [$read_only]($read_only_style))";
      	  style = "bold blue";
      	};
      	nix_shell = {
      	  format = "[$symbol( \($name\))]($style) ";
      	  symbol = "󱄅";
      	  style = "blue";
      	};
      	cmd_duration = {
      	  format = "took [$duration]($style)";
      	};
      	character = {
      	  success_symbol = "[➜](bold green)";
      	  error_symbol = "[➜](bold red)";
      	};
      	scan_timeout = 10;
      	package.disabled = true;
    	};
		};

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y"; # Silence warning related to older `home.stateVersion`
    };

		programs.lsd = {
			enable = true;
			enableZshIntegration = true;
		};

    programs.fastfetch.enable = true;
  };
}
