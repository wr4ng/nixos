{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	
	hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  {
	homeManagerModules = import ./modules/home-manager;

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
	  system = "x86_64-linux";
      modules = [
        ./hosts/desktop/configuration.nix
		inputs.home-manager.nixosModules.default
      ];
    };
  };
}
