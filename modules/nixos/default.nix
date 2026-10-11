{ ... }: {
  imports = [
    ./docker.nix
    ./steam.nix
    ./1password.nix
    ./virt-manager.nix
    ./dtu/program-verification.nix
  ];
}
