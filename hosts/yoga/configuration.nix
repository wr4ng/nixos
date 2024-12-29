# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix              
		inputs.home-manager.nixosModules.default
	];


	# Bootloader.
	grub.enable = true;
	grub.useOSProber = false;

	# Silent boot
	boot.kernelParams = [ "quiet" ];
	boot.consoleLogLevel = 0;

	# Power management
	powerManagement.enable = true;
	powerManagement.powertop.enable = true;
	services.power-profiles-daemon.enable = false; # Disable gnome power management (conflicts with tlp)
	services.tlp.enable = true;

	networking.hostName = "yoga"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Enable nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	programs.zsh.enable = true;

	environment.systemPackages = [
		inputs.ghostty.packages.x86_64-linux.default
	];

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable running non-nix executables (example: stylua installed by Mason in nvim)
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		# Add any missing dynamic libraries for unpackaged programs
		# here, NOT in environment.systemPackages
	];

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
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

	# Enable bluetooth
	hardware.bluetooth.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.wr4ng = {
		isNormalUser = true;
		description = "Mads Christian Wrang Nielsen";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			vim
			git

			wget
			htop
			tree
			unzip
			eza

			networkmanagerapplet
			gcc
			go
			cargo

			pavucontrol
			pamixer

			powertop
		];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"wr4ng" = import ./home.nix;
		};
		backupFileExtension = "backup";
		useUserPackages = true;
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	security.polkit.enable = true;
	#TODO: Move to hyprland module once it is a nix module instead of home-manager
	security.pam.services.hyprlock = {}; # Allow hyprlock to unlock session

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
