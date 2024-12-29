# Taken from: https://github.com/JohnRTitor/nix-conf/blob/546808fc863cf244efc0b639a54f7c8e0c509da4/system/gnome-keyring.nix

# GNOME Keyring for storing/encrypting sycrets
# apps like vscode stores encrypted data using it
{ pkgs, ... }:

{
	services.gnome.gnome-keyring.enable = true;
	environment.systemPackages = [ pkgs.libsecret ]; # libsecret API
	security.pam.services.gdm.enableGnomeKeyring = true; # load gnome-keyring at startup
	environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory
	security.pam.services.login.enableGnomeKeyring = true;
	programs.seahorse.enable = true; # enable the graphical frontend for managing
}
