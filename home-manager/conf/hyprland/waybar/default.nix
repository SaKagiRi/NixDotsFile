{
...
}:
{
	programs.waybar = {
		enable = true;
		style = ./style.css;
		settings = [{
			height = 30;
			layer = "top";
			position = "top";
			modules-center = [ "hyprland/workspaces" ];
			modules-left = [ "group/hardware" "tray" ];
			modules-right = [
				#"custom/update"
				"pulseaudio"
				"network"
				"bluetooth"
				"temperature"
				"clock"
				];
			"group/hardware" = {
				orientation = "horizontal";
				modules = [ "cpu" "memory" ];
			};
			"custom/update" = {
				format = "(-) { }";
				tooltrip-format = "{ }";
				ascape = true;
				return-type = "json";
				exec = "kitty";
				on-click = "kitty";
				tooltrip = false;
			};
			network = {
				format = "ᯤ {}";
				format-disconnected = "Disconnected ⚠︎";
				on-click = "nm-applet";
			};
			bluetooth = {
					format = "ᛒ {}";
					tooltip = true;
					tooltip-format = "- {controller_alias}\t{controller_address}\n- {device_alias}\t{device_address}";
				format-disabled = "ᛒ";
				format-connected = "ᛒ";
				on-click = "blueman-applet";
			};
			pulseaudio = {
				format = "{icon} {volume}%";
				format-bluetooth = "ᛒ {volume}%";
				format-bluetooth-muted = "ᛒ 0%";
				format-icons = {
					default = [ "၊၊||၊" ];
					handsfree = "📱";
					headphones = "🎧";
					headset = "";
					phone = "📞";
					portable = "📞";
				};
			};
			clock = {
				format-alt = "{:%Y-%m-%d}";
				tooltip-format = "{:%Y-%m-%d | %H:%M}";
			};
			memory = {
				format = "RAM: {}%";
			};
			cpu = {
				format = "CPU: {usage}%";
				tooltip = false;
			};
			temperature = {
				format = "🌡 {}";
			};
		}];
	};
}
