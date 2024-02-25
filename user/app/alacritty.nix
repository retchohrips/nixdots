{
  config,
  userSettings,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12;
        normal = {
          family = "${userSettings.font}";
          style = "Regular";
        };
      };
      colors = {
        primary = {
          background = "#${palette.base00}";
          foreground = "#${palette.base05}";
        };
        cursor = {
          text = "#${palette.base00}";
          cursor = "#${palette.base05}";
        };
        normal = {
          black = "#${palette.base00}";
          red = "#${palette.base08}";
          green = "#${palette.base0B}";
          yellow = "#${palette.base0A}";
          blue = "#${palette.base0D}";
          magenta = "#${palette.base0E}";
          cyan = "#${palette.base0C}";
          white = "#${palette.base05}";
        };
        bright = {
          black = "#${palette.base03}";
          red = "#${palette.base08}";
          green = "#${palette.base0B}";
          yellow = "#${palette.base0A}";
          blue = "#${palette.base0D}";
          magenta = "#${palette.base0E}";
          cyan = "#${palette.base0C}";
          white = "#${palette.base07}";
        };
      };
    };
  };
}
