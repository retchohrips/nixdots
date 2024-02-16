{
  config,
  userSettings,
  ...
}: let
  colors = import ../../colors.nix;
in {
  programs.rofi = {
    enable = true;
    theme = with colors.scheme.catppuccin-mocha; let
      mkL = config.lib.formats.rasi.mkLiteral;
    in {
      "*" = {
        background-color = mkL "transparent";
        text-color = mkL text;
        font = "${userSettings.font} 14";
      };

      window = {
        padding = mkL "1em";
        border-color = mkL "${text}30";
        border = mkL "1px";
        border-radius = mkL "6px";
        background-color = mkL "${crust}80";
      };

      mainbox = {
        spacing = 0;
        children = map mkL ["message" "inputbar" "listview"];
      };

      message = {
        enabled = true;
        margin = mkL "0px 100px";
        padding = mkL "15px";
        border = 0;
        border-radius = mkL "6px";
        border-color = mkL "inherit";
        background-color = mkL "inherit";
        text-color = mkL "inherit";
        size = mkL "400em";
      };

      element = {
        background = mkL "transparent";
        children = map mkL ["element-icon" "element-text"];
      };

      "element,element-text,element-icon,button" = {
        cursor = mkL "pointer";
      };

      inputbar = {
        margin = mkL "0px 10px";
        spacing = mkL "0.4em";
        border-radius = mkL "6px";
        border = mkL "1px";
        border-bottom = mkL "3px";
        background-color = mkL "${crust}55";
        border-color = mkL "${text}20";
        children = map mkL ["entry" "overlay" "case-indicator"];
      };

      "listview, message" = {
        padding = mkL "0.5em";
        border = mkL "1px";
        border-radius = 0;
        border-color = "${text}20";
        background-color = mkL "transparent";
        columns = 3;
        lines = 7;
      };

      listview = {
        border = 0;
        spacing = mkL "10px";
        background-color = mkL "transparent";
        border-color = mkL "${text}20";
        scrollbar = false;
      };

      element = {
        border = mkL "1px";
        border-radius = mkL "3px";
        padding = mkL "5px";
        border-color = mkL "${text}20";
      };

      element-text = {
        background-color = mkL "transparent";
        text-color = mkL "${text}cc";
        font = "${userSettings.font} 13";
      };

      "element normal.normal" = {
        background-color = mkL "${crust}55";
      };

      "element.alternate.normal" = {background-color = mkL "${crust}55";};

      "element.selected.normal" = {background-color = mkL "${text}20";};

      entry = {
        placeholder = "Search here";
        placeholder-color = mkL "${text}20";
        border-color = mkL "transparent";
        background-color = mkL "transparent";
        border = mkL "10px";
        text-color = mkL "${text}cc";
      };
    };
  };
}
