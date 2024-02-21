{
  userSettings,
  config,
  inputs,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = let
      inherit (builtins) attrNames attrValues map readFile replaceStrings toString;

      fontValue = userSettings.font;
      baseNames = attrNames config.colorscheme.palette;
      baseValues = attrValues config.colorscheme.palette;
      baseRGB = map (inputs.nix-colors.lib-core.conversions.hexToRGBString ", ") baseValues;
      style = readFile ./style.css;
    in
      replaceStrings baseNames baseRGB style;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = ["hyprland/workspaces" "mpd"];
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
            # active = "";
            # default = "";
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            # "10"= "〇";
          };
          sort-by-number = true;
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace +1";
          on-scroll-down = "hyprctl dispatch workspace -1";
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
          format-charging = "󱐋 {capacity}%";
          max-length = 16;
        };
        network = {
          format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
          format-wifi = "{icon}";
          format-disconneced = "󰤮";
          tooltip-format = "{signaldBm}dBm {essid} {frequency}GHz";
          on-click = "nm-connection-editor";
        };
        bluetooth = {
          format = "";
          on-click = "blueman-manager";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
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
  };
}
