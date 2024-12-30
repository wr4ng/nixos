{ lib, config, ... }:

{
	options = {
		wlogout.enable = lib.mkEnableOption "enables wlogout";
	};

	config = lib.mkIf config.wlogout.enable {
		# Symlink icons to be used by wlogout
		home.file.".config/wlogout/icons".source = ./icons;

		programs.wlogout = {
			enable = true;
			layout = [
				{
					label = "lock";
					action = "sleep 1; hyprlock";
					text = "Lock";
					keybind = "l";
				}
				{
					label = "hibernate";
					action = "systemctl hibernate";
					text = "Hibernate";
					keybind = "h";
				}
				{
					label = "logout";
					action = "hyprctl dispatch exit";
					text = "Logout";
					keybind = "e";
				}
				{
					label = "shutdown";
					action = "systemctl poweroff";
					text = "Shutdown";
					keybind = "s";
				}
				{
					label = "suspend";
					action = "systemctl suspend";
					text = "Suspend";
					keybind = "u";
				}
				{
					label = "reboot";
					action = "systemctl reboot";
					text = "Reboot";
					keybind = "r";
				}
			];
			style = ''
			* {
				font-family: "Jetbrains Nerd Font Mono", Roboto, Helvetica, Arial, sans-serif;
				background-image: none;
				transition: 20ms;
				box-shadow: none;
			}

			window {
				background-color: rgba(30, 31, 41, 0.8);
			}

			button {
				color: #FFFFFF;
				font-size:20px;

				background-repeat: no-repeat;
				background-position: center;
				background-size: 25%;

				border-style: solid;
				background-color: #282a36;
				border: 3px solid #FFFFFF;

				box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			}

			button:focus,
			button:active,
			button:hover {
				color: #bd93f9;
				background-color: rgba(12, 12, 12, 0.7);
				border: 3px solid #bd93f9;

			}

			/* Buttons */
			#lock {
				margin: 10px;
				border-radius: 20px;
				background-image: image(url("icons/lock.png"));
			}

			#logout {
				margin: 10px;
				border-radius: 20px;
				background-image: image(url("icons/logout.png"));
			}

			#suspend {
				margin: 10px;
				border-radius: 20px;
				background-image: image(url("icons/suspend.png"));
			}

			#hibernate {
				margin: 10px;
				border-radius: 20px;
				background-image: image(url("icons/hibernate.png"));
			}

			#shutdown {
				margin: 10px;
				border-radius: 20px;
				background-image: image(url("icons/shutdown.png"));
			}

			#reboot {
				margin: 10px;
				border-radius: 20px;
				background-image: image(url("icons/reboot.png"));
			}
			'';
		};
	};
}
