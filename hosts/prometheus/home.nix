{
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.self.outputs.homeManagerModules.default ];

  home.username = "wr4ng";
  home.homeDirectory = "/home/wr4ng";

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Mads Christian Wrang Nielsen";
        email = "madscwn@gmail.com";
      };
    };
  };

  modules.hledger.enable = true;

  home.packages = with pkgs; [
    # Nix helper
    nh

    # Programming
    gcc
    rustup
    python3
    typst
    tinymist

    # Core applications
    brave
    vscode
    obsidian
    discord
    bitwarden-desktop
    mission-center

    # General
    spotify
    freecad
    pdfarranger
    pinta
    orca-slicer
    signal-desktop
    switcheroo
	solaar

    # Video + Audio
    ffmpeg
    handbrake
    mpv
    celluloid
    # qpwgraph
    # pavucontrol
    # easyeffects

	davinci-resolve-studio
  ];

  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
