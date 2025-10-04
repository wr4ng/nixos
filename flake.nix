{
  description = "My NixOS flake :))";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs: {
    nixosConfigurations.nyx = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        } # Module to enable experimental nix features needed for flakes
        ./hosts/nyx/configuration.nix
        ./modules/nixos
        inputs.home-manager.nixosModules.default
      ];
    };

    homeManagerModules.default = ./modules/home-manager;
  };
}
