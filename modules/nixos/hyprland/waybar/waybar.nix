{ pkgs, lib, config, ... }:

{
	options = {
		waybar.enable = lib.mkEnableOption "enables Waybar";
		waybar.backlight.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "enables backlight information in the Waybar configuration";
		};
	};

	config = lib.mkIf config.waybar.enable {
		home.packages = with pkgs; [
			waybar
		] ++ (if config.waybar.backlight.enable then [ brightnessctl ] else []); # Add brightnessctl to control backlight TODO: Should probably set somewhere else. Maybe a modules.laptop.enable option?

		home.file.".config/waybar/style.css".source = ./style.css;
		home.file.".config/waybar/config.jsonc".text = ''
	{
		"layer": "top",
		"height": 42,
		"position": "top",
		"exclusive": true,
		"passthrough": false,
		"gtk-layer-shell": true,
		"modules-left": [
			"hyprland/workspaces"
		],
		"modules-center": [
			"hyprland/window"
		],
		"modules-right": [
			"tray",
			"network",
			${if config.waybar.backlight.enable then ''
			"backlight",
			'' else ""}
			"pulseaudio",
			"pulseaudio#microphone",
			"battery",
			"clock",
			"custom/power"
		],
		"hyprland/workspaces": {
			"format": "{icon} {id}",
			"format-icons": {
				"active": "",
				"default": ""
			},
			"on-click": "activate",
			"disable-scroll": true,
			"all-outputs": true
		},
		"hyprland/window": {
			"max-length": 40
		},
		"tray": {
			"icon-size": 14,
			"spacing": 13,
			"show-passive-items": true
		},
		"clock": {
			"format": "{:%H:%M}  ",
			"format-alt": "{:%A, %Y-%m-%d (%R)}  ",
			"tooltip-format": "<tt>{calendar}</tt>",
			"calendar": {
				"mode"          : "month",
				"mode-mon-col"  : 3,
				"weeks-pos"     : "right",
				"on-scroll"     : 1,
				"on-click-right": "mode",
				"format": {
					"months":     "<span color='#ffead3'><b>{}</b></span>",
					"days":       "<span color='#ecc6d9'><b>{}</b></span>",
					"weeks":      "<span color='#bd93f9'><b>W{}</b></span>",
					"weekdays":   "<span color='#bd93f9'><b>{}</b></span>",
					"today":      "<span color='#ff6699'><b><u>{}</u></b></span>"
				}
			},
			"actions": {
				"on-click-right": "mode",
				"on-click-forward": "tz_up",
				"on-click-backward": "tz_down",
				"on-scroll-up": "shift_up",
				"on-scroll-down": "shift_down"
			}
		},
		"backlight": {
			"format": "{icon} {percent}%",
			"format-icons": ["󰃞", "󰃟", "󰃠"],
			"reverse-scrolling": true,
			"on-scroll-up": "brightnessctl --min-value=20 set 1%+",
			"on-scroll-down": "brightnessctl --min-value=20 set 1%-",
			"min-length": 6
		},
		"battery": {
			"states": {
				"good": 80,
				"warning": 30,
				"critical": 20
			},
			"format": "{icon} {capacity}%",
			"format-charging": " {capacity}%",
			"format-plugged": " {capacity}%",
			"format-alt": " {time} {icon}",
			"format-time": "{H}h {M}min",
			"format-icons": ["󰂃", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
		},
		"pulseaudio": {
			"format": "{icon} {volume}%",
			"tooltip": false,
			"format-muted": " ",
			"on-click": "pavucontrol",
			"on-click-right": "pamixer --toggle-mute",
			"scroll-step": 1,
			"format-icons": {
				"headphone": "",
				"hands-free": "",
				"headset": "",
				"phone": "",
				"portable": "",
				"car": "",
				"default": ["", "", "", " "]
			}
		},
		"pulseaudio#microphone": {
			"format": "{format_source}",
			"format-source": " {volume}%",
			"format-source-muted": " ",
			"on-click": "pamixer --default-source -t",
			"on-scroll-up": "pamixer --default-source -i 5",
			"on-scroll-down": "pamixer --default-source -d 5",
			"scroll-step": 1
		},
		"network": {
			"format-wifi": "{icon} {essid}({signalStrength}%)",
			"format-ethernet": "󰈀 {ipaddr}",
			"format-disconnected": "󰤮 ",
			"format-icons": ["󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "],
			"tooltip-format-wifi": "{essid}",
			"on-click": "nm-connection-editor"
		},
		"custom/power": {
			"format": "",
			"tooltip": false,
			"on-click": "wlogout -P 1 --protocol layer-shell"
		},
		"custom/separator": {
			"format": "|",
			"interval": "once",
			"tooltip": false
		}
	}
		'';
	};
}
