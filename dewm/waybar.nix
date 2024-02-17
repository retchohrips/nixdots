let
  colors = import ../../colors.nix;
in {
  programs.waybar = {
    enable = true;
    style = with colors.scheme.catppuccin-mocha;
    /*
    css
    */
      ''
        * {
          border-radius: 12px;
          font-family: CommitMono, "Symbols Nerd Font";
          color: ${text};
          font-size: 14px;
        }

        window#waybar {
          background: rgba(30, 30, 46, 0.65);
          border-radius: 0px;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #window {
          transition: none;
          color: transparent;
          background: transparent;
        }

        #network, #bluetooth, #battery, #wireplumber, #backlight, #mpd {
          border: 1px solid ${overlay0};
          background-color: rgba(255, 255, 255, 0.05);
          transition: none;
          margin-top: 6px;
          margin-bottom: 6px;
        }

        #network {
          border-radius: 0px 6px 6px 0px;
          border-left: 0px transparent;
          padding-right: 10px;
          margin-right: 20px;
        }

        #bluetooth {
          border-radius: 6px 0px 0px 6px;
          border-right: 0px transparent;
          margin-left: 20px;
          padding-right: 20px;
          padding-left: 10px;
        }

        #battery {
          border-radius: 0px 6px 6px 0px;
          border-left: 0px transparent;
          padding-right: 10px;
          margin-right: 20px;
        }

        #backlight {
          border-radius: 6px 0px 0px 6px;
          border-right: 0px transparent;
          padding-right: 20px;
          padding-left: 10px;
        }

        #battery.charging {
          color: ${green};
        }

        #wireplumber {
          border-radius: 6px;
          margin-right: 20px;
          padding-left: 10px;
          padding-right: 10px;
        }

        #clock {
          transition: none;
          border: none;
          background: transparent;
          margin-top: 6px;
          margin-bottom: 6px;
        }

        #mpd {
          padding-left: 10px;
          padding-right: 10px;
          margin-left: 20px;
          border-radius: 6px;
        }

        #mpd.stopped {
          opacity: 0;
        }
      '';
    settings = {
      mainBar = {
        layer = "top";
        modules-left = ["mpd"];
        modules-center = ["clock"];
        modules-right = ["tray" "bluetooth" "network" "wireplumber" "backlight" "battery"];
        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " MUTE";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          max-volume = 100;
          format-icons = ["" "" "" "" ""];
          scroll-step = 5;
        };
        backlight = {format = " {percent}%";};
        clock = {
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
          sort-by-number = true;
          on-click = "activate";
        };
        mpd = {
          format = "{stateIcon} {title} - {artist}";
          state-icons = {
            paused = "";
            playing = "";
          };
          max-length = 70;
          tooltip-format = "";
          on-click = "mpc toggle";
        };
        tray = {
          icon-size = 15;
          spacing = 20;
        };
        battery = {
          format = "{icon} {capacity%}";
          format-icons = ["" "" "" "" ""];
          format-charging = "󰢝 {capacity}%";
          max-length = 16;
        };
        network = {
          format-wifi = "";
          format = "";
          tooltip-format = "{signaldBm}dBm {essid} {frequency}GHz";
          on-click = "nm-connection-editor";
        };
        bluetooth = {
          format = "";
          on-click = "blueman-manager";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
      };
    };
  };
}
