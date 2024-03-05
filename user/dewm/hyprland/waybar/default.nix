{
  config,
  systemSettings,
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
        modules-left = ["custom/launcher" "hyprland/workspaces" "temperature" "wireplumber" "mpd"];
        modules-center = ["custom/weather" "clock"];
        modules-right =
          if (systemSettings.hostname == "pawpad")
          then ["bluetooth" "network" "backlight" "battery" "tray"]
          else ["bluetooth" "network" "tray"];

        "custom/launcher" = {
          format = " ";
          on-click = "rofi -show drun || pkill rofi";
          tooltip = false;
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
          tooltip = false;
          format = "{icon} {percent}%";
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
          format = "{:%I:%M %p %A %b %d}";
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
          format = "<span color='${withHashtag.base0E}'></span> {title}";
          format-paused = "  {title}";
          format-stopped = "<span foreground='${withHashtag.base0E}'></span>";
          fromat-disconnected = "";
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
          format-disconneced = "󰤮";
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
          * {
            border-radius: 1rem;
            font-family: ${config.stylix.fonts.monospace.name};
            color: ${withHashtag.base05};
            font-size: 1rem;
            transition-property: background-color;
            background-color: ${withHashtag.base00};
          }

          @keyframes blink_red {
            to {
              background-color: ${withHashtag.base08};
              color: ${withHashtag.base00};
            }
          }

          .warning:not(.charging),
          .critical:not(.charging),
          .urgent:not(.charging) {
            animation-name: blink_red;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #clock,
          #temperature,
          #custom-weather,
          #mpd,
          #backlight,
          #bluetooth,
          #wireplumber,
          #network,
          #battery,
          #custom-launcher,
          #tray {
            padding-left: 0.6rem;
            padding-right: 0.6rem;
          }

        /* Bar */
          window#waybar {
            background-color: transparent;
          }

          window > box {
            background-color: transparent;
            margin: 0.3rem;
            margin-bottom: 0;
          }

          /* Workspaces */
          #workspaces:hover {
            background-color: ${withHashtag.base0B};
          }

          #workspaces button {
            padding-right: 0.4rem;
            padding-left: 0.4rem;
            padding-top: 0.1rem;
            padding-bottom: 0.1rem;
            background: transparent;
          }

          #workspaces button.focused,
          #workspaces button.active * {
            color: ${withHashtag.base0D};
          }

          #workspaces button.hover {
            color: ${withHashtag.base06};
          }

          /* Tooltips */
          tooltip {
            background-color: ${withHashtag.base00};
          }

          tooltip label {
            color: ${withHashtag.base06};
          }

          /* Battery */
          #battery {
            color: ${withHashtag.base0E};
          }

          #battery.full {
            color: ${withHashtag.base0B};
          }

          #battery.charging {
            color: ${withHashtag.base0C};
          }

          #battery.discharging {
            color: ${withHashtag.base09};
          }

          #battery.critical:not(.charging) {
            color: ${withHashtag.base0F};
          }

          /* MPD */
          #mpd.paused {
            color: ${withHashtag.base0F};
            font-style: italic;
          }

          #mpd.stopped {
            color: ${withHashtag.base06};
          }

          #mpd {
            color: ${withHashtag.base07};
          }

          /* Extra */
          #custom-launcher {
            color: ${withHashtag.base0A};
          }

          #clock {
            color: ${withHashtag.base06};
          }

          #temperature {
            color: ${withHashtag.base09};
          }

          #backlight {
            color: ${withHashtag.base0A};
          }

          #wireplumber {
            color: ${withHashtag.base0E};
          }

          #network {
            color: ${withHashtag.base0F};
          }

          #network.disconnected {
            color: ${withHashtag.base05};
          }

          #custom-weather {
            color: ${withHashtag.base08};
          }

          #bluetooth {
            color: ${withHashtag.base05};
          }

          #bluetooth.connected {
            color: ${withHashtag.base0D};
          }
      '';
  };
  home.packages = [
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
