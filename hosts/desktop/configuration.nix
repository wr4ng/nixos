{ pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix 				# Include the results of the hardware scan
		inputs.self.nixosModules 					# Import my nixos modules
		inputs.home-manager.nixosModules.default 	# Import home-manager
	];

	# Enable and configure modules
	# Bootloader
	grub.enable = true;
	grub.useOSProber = true;
	grub.gfxmodeEfi = "2560x1440"; # Set main monitor size for grub menu
	# GPU drivers
	nvidia-drivers.enable = true;

	# Enable hyprland module
	modules.hyprland.enable = true;
	modules.hyprland.waybar.backlight.enable = false; # disable backlight waybar module

	# Gaming
	programs.gui.steam.enable = true;
	programs.gui.lutris.enable = true;

	# Enable my Android-Studio module
	modules.android-studio.enable = true;

	# Setup home-manager
	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"wr4ng" = import ./home.nix;
		};
		backupFileExtension = "backup";
		useUserPackages = true;
	};

	# Define your hostname.
	networking.hostName = "desktop";

	# Use latest linux kernel
	boot.kernelPackages = pkgs.linuxPackages_latest;

	# Enable networking
	networking.networkmanager.enable = true;

	# Enable my bluetooth module
	modules.bluetooth.enable = true;

	# Setup logitech
	hardware.logitech.wireless.enable = true;
	hardware.logitech.wireless.enableGraphical = true;

	# Ollama + Alpaca setup
	services.ollama = {
		enable = true;
		acceleration = "cuda";
	};
	services.open-webui.enable = true;

	services.libinput.mouse.accelProfile = "flat";

	services.ratbagd.enable = true;

	environment.systemPackages = with pkgs; [
		#TODO: Move to modules?
		solaar
		piper
		pyprland
		unityhub
		godot_4
		freecad-wayland
	];

	# Set your time zone.
	time.timeZone = "Europe/Copenhagen";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_DK.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "da_DK.UTF-8";
		LC_IDENTIFICATION = "da_DK.UTF-8";
		LC_MEASUREMENT = "da_DK.UTF-8";
		LC_MONETARY = "da_DK.UTF-8";
		LC_NAME = "da_DK.UTF-8";
		LC_NUMERIC = "da_DK.UTF-8";
		LC_PAPER = "da_DK.UTF-8";
		LC_TELEPHONE = "da_DK.UTF-8";
		LC_TIME = "da_DK.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "dk";
		variant = "";
	};

	# Configure console keymap
	console.keyMap = "dk-latin1";

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# XDG portal setup.
	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	services.pulseaudio = {
		enable = false;
	};
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Polkit setup.
	security.polkit.enable = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?
}
