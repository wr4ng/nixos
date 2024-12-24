# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix              
			./../../modules/nixos/main-user.nix #TODO: Import the other way!
			inputs.home-manager.nixosModules.default
		];

	# Bootloader.
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.grub = {
		enable = true;
		efiSupport = true;
		useOSProber = true;
		device = "nodev";
		theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
		fontSize = 12;
		gfxmodeEfi = "2560x1440";
		extraEntries = ''
	  menuentry "Reboot" {
		  reboot
	  }
	  menuentry "Poweroff" {
		  halt
	  }
		'';
	};

	# Enable opengl.
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	# Enable nvidia drivers (for both wayland and X11).
	services.xserver.videoDrivers = ["nvidia"];
	hardware.nvidia = {
		# Modesetting is required.
		modesetting.enable = true;

		powerManagement.enable = false;
		powerManagement.finegrained = false;

		open = false;

		nvidiaSettings = true;

		# Set driver version to 'stable'.
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	# Define your hostname.
	networking.hostName = "nixos-desktop"; 

	# Enable nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Enable networking
	networking.networkmanager.enable = true;

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

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# Enable hyprland.
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "dk";
		variant = "";
	};

	# Configure console keymap
	console.keyMap = "dk-latin1";

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
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

	# Enable bluetooth
	hardware.bluetooth.enable = true;

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Install firefox.
	programs.firefox.enable = true;

	# Install zsh.
	programs.zsh.enable = true;

	# Install Steam.
	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;
	programs.gamemode.enable = true;

	# Setup protonGE path.
	environment.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/wr4ng/.steam/root/compatibilitytools.d";
		# Hint to election apps to use wayland. TODO: This should only be set when using wayland?
		NIXOS_OZONE_WL = "1";
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"wr4ng" = import ./home.nix;
		};
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [

		zsh
		neovim
		vim
		wget
		tree
		gcc
		fzf
		git
		stow
		unzip
		zsh
		mangohud
		protonup
		waybar
		swww
		rofi-wayland
		networkmanagerapplet
		eza
		wl-clipboard
		#TODO slurp + grim
		go
		cargo
		htop
		pavucontrol
		lxqt.lxqt-policykit
	];

	# XDG portal setup.
	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	# Polkit setup.
	security.polkit.enable = true;

	# 1Password setup.
	programs._1password.enable = true;
	programs._1password-gui = {
		enable = true;
		polkitPolicyOwners = [ "wr4ng" ]; #TODO: Replace with username!
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
