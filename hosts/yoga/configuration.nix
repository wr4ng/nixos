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

	# AMD driver setup
	boot.initrd.kernelModules = [ "amdgpu" ];	# Let kernel load amdgpu early
	hardware.graphics = { 						# Setup OpenGL
		enable = true;
		enable32Bit = true; 					# If you need 32-bit support for Steam or Wine.
		extraPackages = with pkgs; [			# Vulkan packages
			vulkan-loader
			vulkan-validation-layers
			vulkan-extension-layer
		];
	};
	services.xserver.videoDrivers = [ "amdgpu" ]; 	# Ensure X11 used amdgpu, i.e. if I want to open Gnome X11 for compatibility

	# Power management
	powerManagement.enable = true;
	powerManagement.powertop.enable = true;
	services.power-profiles-daemon.enable = false; # Disable gnome power management (conflicts with tlp)
	services.tlp.enable = true;

	networking.hostName = "yoga"; # Define your hostname.

	# Enable networking
	networking.networkmanager.enable = true;

	# Enable my bluetooth module
	modules.bluetooth.enable = true;

	# Enable nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Enable my hyprland module
	modules.hyprland.enable = true;

	# Enable my steam module
	programs.gui.steam.enable = true;

	# Enable my Android-Studio module
	modules.android-studio.enable = true;

	# Enable my virt-manager module
	modules.virt-manager.enable = true;

	programs.gnupg.agent.enable = true;

	# Ollama + Alpaca setup
	programs.ollama.enable = true;

	environment.systemPackages = with pkgs; [
		adwaita-qt
		bottles
		freecad-wayland
		openjdk
		maven
		unityhub
		dotnet-sdk
		nil
		cargo
		rustc
		gnome-tweaks
		handbrake
		ffmpeg
		godot_4
		freecad
		orca-slicer
		jq
		nwg-look
		xfce.thunar
	];

	networking.firewall.enable = false;

	# QT
	#environment.sessionVariables = {
	#	QT_STYLE_OVERRIDE = "adwaita-dark";
	#};

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
	services.pulseaudio.enable = false;
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
	xdg.portal.extraPortals = [
		pkgs.xdg-desktop-portal-gtk
		pkgs.xdg-desktop-portal-wlr
		pkgs.xdg-desktop-portal-gnome
		pkgs.xdg-desktop-portal-hyprland
	];

	security.polkit.enable = true;

	#environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
