{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
		hyprpanel = {
			url = "github:Jas-SinghFSU/HyprPanel";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};
		hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";

		nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
	};

	outputs = { self, nixpkgs, hyprpanel,... } @ inputs:
		let
			system = "x86_64-linux";
		in
			{

			nixosModules = import ./modules/nixos;
			homeManagerModules = import ./modules/home-manager;

			nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; inherit system; };
				system = "x86_64-linux";
				modules = [
					./hosts/desktop/configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};

			nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; inherit system; };
				system = "x86_64-linux";
				modules = [
					./hosts/yoga/configuration.nix
					./modules/nixos
					inputs.home-manager.nixosModules.default
				];
			};
		};
}
