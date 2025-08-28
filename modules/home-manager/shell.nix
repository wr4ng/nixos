{ pkgs, lib, config, ... }: {

  options = {
    module.shell.enable = lib.mkEnableOption "enable shell module";
  };

  config = lib.mkIf config.module.shell.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "history"
        ];
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
