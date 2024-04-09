{
  config,
  osConfig,
  pkgs,
  ...
}:
with config.lib.stylix.colors; {
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        spacing = 3;
        fixed-center = true;
        margin-top = 6;
        margin-left = 6;
        margin-right = 6;
        modules-left = [
          "hyprland/workspaces"
          "custom/separator#line"
          # "temperature"
          "wireplumber"
          "custom/separator#line"
          "mpd"
        ];
        modules-center = [
          "custom/weather"
          "custom/separator#line"
          "clock"
        ];
        modules-right =
          if (osConfig.modules.device.type == "laptop")
          then [
            "bluetooth"
            "network"
            "custom/separator#line"
            "backlight"
            "battery"
            "custom/separator#line"
            "tray"
            "custom/separator#line"
            "custom/swaync"
          ]
          else [
            "bluetooth"
            "network"
            "custom/separator#line"
            "tray"
            "custom/separator#line"
            "custom/swaync"
          ];

        # Separators
        "custom/separator#dot" = {
          format = "";
          intercal = "once";
          tooltip = false;
        };

        "custom/separator#dot-line" = {
          format = "";
          intercal = "once";
          tooltip = false;
        };

        "custom/separator#line" = {
          format = "|";
          intercal = "once";
          tooltip = false;
        };

        "custom/swaync" = {
          tooltip = true;
          format = "{icon} {}";
          format-icons = {
            "notification" = "<span foreground='${withHashtag.base08}'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='${withHashtag.base08}'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='${withHashtag.base08}'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='${withHashtag.base08}'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " MUTE";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          max-volume = 100;
          format-icons = ["" "" "" "" ""];
          scroll-step = 5;
        };

        backlight = {
          tooltip-format = "{percent%}";
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = "waybar-weather";
          return-type = "json";
        };

        clock = {
          format = "{:%I:%M %p %a, %b %d}";
          tooltip-format = "{:%A, %B %d %Y}\n<tt>{calendar}</tt>";
          interval = 1;
        };

        "hyprland/workspaces" = {
          # format = "{icon}";
          # format-icons = {
          # active = "";
          # default = "";
          # "1" = "一";
          # "2" = "二";
          # "3" = "三";
          # "4" = "四";
          # "5" = "五";
          # "6" = "六";
          # "7" = "七";
          # "8" = "八";
          # "9" = "九";
          # "10"= "〇";
          # };
          sort-by-number = true;
          disable-scroll = false;
          reverse-scroll = true;
          on-scroll-up = "hyprctl dispatch workspace +1";
          on-scroll-down = "hyprctl dispatch workspace -1";
        };

        mpd = {
          format = " {title}";
          format-paused = "  {title}";
          format-stopped = "";
          format-disconnected = "";
          max-length = 25;
          tooltip-format = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
          on-click = "mpc --quiet toggle";
          on-click-middle = "kitty ncmpcpp";
          on-scroll-up = "mpc --quiet prev";
          on-scroll-down = "mpc --quiet next";
          smooth-scrolling-threshold = 5;
        };

        tray = {
          icon-size = 15;
          spacing = 5;
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "󰂄 {capacity}%";
          interval = 10;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        network = {
          format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
          format-wifi = "{icon}";
          format-disconnected = "󰤮";
          tooltip-format = "{signaldBm}dBm {essid} {frequency}GHz";
          on-click = "nmtui-connect";
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
          critical-threshold = 80;
          tooltip = false;
          format = " {temperatureC}°C";
        };

        bluetooth = {
          format = "";
          on-click = "rofi-bluetooth";
          format-connected = " {num_connections}";
          format-connected-battery = " {device_battery_percentage}%";
          tooltip-format = ''
            {controller_alias}	{controller_address}

            {num_connections} connected'';
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	{device_battery_percentage}%";
        };
      };
    };
    style =
      /*
      css
      */
      ''
        /* General */
        * {
          font-family: "Symbols Nerd Font", ${config.stylix.fonts.sansSerif.name};
          padding: 1px;
          min-height: 0px;
        }

        window#waybar {
          background-color: transparent;
          color: ${withHashtag.base05};
          transition-property: none;
          border-radius: 10px;
          border-color: transparent;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #waybar.empty #window {
          background: none;
        }

        .modules-left, .modules-center, .modules-right {
          background: alpha(${withHashtag.base00}, 0.5);
          padding-top: 2px;
          padding-bottom: 2px;
          padding-left: 4px;
          padding-right: 4px;
          border-radius: 10px;
        }

        tooltip {
          background: ${withHashtag.base00};
          opacity: 0.8;
          border-radius: 10px;
          border: 2px solid ${withHashtag.base01};
        }

        tooltip label {
          color: ${withHashtag.base05};
        }

        #workspaces button {
          background-color: transparent;
          color: ${withHashtag.base05};
          border-radius: 9px;
          padding-left: 4px;
          padding-right: 4px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.focused, #workspaces button.active * {
          color: ${withHashtag.base0D};
          padding-left: 8px;
          padding-right: 8px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.hover {
          color: ${withHashtag.base06};
          background: alpha(${withHashtag.base01}, 0.2);
          padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
        }

        #custom-separator {
          color: ${withHashtag.base03};
          margin-left: 2px;
          margin-right: 2px;
        }

        #clock {
          color: ${withHashtag.base07};
        }

        #battery {
          color: ${withHashtag.base0E}
        }

        #battery.charging {
          color: ${withHashtag.base0C};
        }

        @keyframes blink {
          to {
            color: ${withHashtag.base08};
          }
        }

        #battery.critical:not(.charging) {
          animation-name: blink;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #bluetooth {
          color: ${withHashtag.base04};
          margin-right: 2px;
        }

        #bluetooth.connected {
          color: ${withHashtag.base0D};
        }

        #wireplumber {
          color: ${withHashtag.base0F};
        }

        #wireplumber.muted {
          color: ${withHashtag.base04};
        }

        #mpd {
          color: ${withHashtag.base07};
        }

        #mpd.paused {
          /* font-style: italic; */
          color: ${withHashtag.base04};
        }

        #mpd.stopped {
          color: ${withHashtag.base04};
        }

        #custom-weather {
          color: ${withHashtag.base09};
        }

        #network {
          color: ${withHashtag.base0F};
        }

        #network.disconnected {
          color: ${withHashtag.base08};
        }

        #backlight {
          color: ${withHashtag.base0A};
          margin-right: 2px;
        }
      '';
  };
  home.packages = [
    pkgs.rofi-bluetooth
    (pkgs.writeScriptBin "waybar-weather"
      /*
      python
      */
      ''
        #!/usr/bin/env python

        import json
        import requests
        from datetime import datetime

        WEATHER_CODES = {
            '113': '󰖙',
            '116': '󰖕',
            '119': '󰖐',
            '122': '',
            '143': '󰖑',
            '176': '',
            '179': '',
            '182': '',
            '185': '',
            '200': '',
            '227': '',
            '230': '',
            '248': '󰖑',
            '260': '󰖑',
            '263': '',
            '266': '',
            '281': '',
            '284': '',
            '293': '',
            '296': '',
            '299': '',
            '302': '',
            '305': '',
            '308': '',
            '311': '',
            '314': '',
            '317': '',
            '320': '',
            '323': '',
            '326': '',
            '329': '',
            '332': '',
            '335': '',
            '338': '',
            '350': '',
            '353': '',
            '356': '',
            '359': '',
            '362': '',
            '365': '',
            '368': '',
            '371': '',
            '374': '',
            '377': '',
            '386': '',
            '389': '',
            '392': '',
            '395': ''
        }

        data = {}


        weather = requests.get("https://wttr.in/?format=j1").json()


        def format_time(time):
            return time.replace("00", "").zfill(2)


        def format_temp(temp):
            return (hour['FeelsLikeF']+"°").ljust(3)


        def format_chances(hour):
            chances = {
                "chanceoffog": "Fog",
                "chanceoffrost": "Frost",
                "chanceofovercast": "Overcast",
                "chanceofrain": "Rain",
                "chanceofsnow": "Snow",
                "chanceofsunshine": "Sunshine",
                "chanceofthunder": "Thunder",
                "chanceofwindy": "Wind"
            }

            conditions = []
            for event in chances.keys():
                if int(hour[event]) > 0:
                    conditions.append(chances[event]+" "+hour[event]+"%")
            return ", ".join(conditions)


        data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
            " "+weather['current_condition'][0]['FeelsLikeF']+"°"

        data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_F']}°</b>\n"
        data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeF']}°\n"
        data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
        data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
        for i, day in enumerate(weather['weather']):
            data['tooltip'] += f"\n<b>"
            if i == 0:
                data['tooltip'] += "Today, "
            if i == 1:
                data['tooltip'] += "Tomorrow, "
            data['tooltip'] += f"{day['date']}</b>\n"
            data['tooltip'] += f"⬆️ {day['maxtempC']}° ⬇️ {day['mintempC']}° "
            data['tooltip'] += f"🌅 {day['astronomy'][0]['sunrise']} 🌇 {day['astronomy'][0]['sunset']}\n"
            for hour in day['hourly']:
                if i == 0:
                    if int(format_time(hour['time'])) < datetime.now().hour-2:
                        continue
                data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_temp(hour['FeelsLikeF'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"


        print(json.dumps(data))
      '')
  ];
}
