{ lib, config, ... }: {

  options = { module.shell.enable = lib.mkEnableOption "enable shell module"; };

  config = lib.mkIf config.module.shell.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "history" ];
      };
      shellAliases = {
        cd = "z";
        open = "xdg-open";
      };
      initContent = ''
        if [[ -n "$IN_NIX_SHELL" ]]; then
          PROMPT="(nix) $PROMPT"
        fi
      '';
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
    };

    programs.fastfetch.enable = true;
  };
}
