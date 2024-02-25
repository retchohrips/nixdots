{
  userSettings,
  config,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # font = "${userSettings.font}";
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        vertical_alignment = "center";
        # The frequency at which text can scroll in the notification, we disable it.
        # We use word_wrap instead.
        word_wrap = "yes";
        ignore_newline = "no";
        # Disable icons
        icon_position = "off";
        width = "300";
        offset = "10x10";

        # Shrink window if it's smaller than the width.
        shrink = "no";

        # Display indicators for URLs (U) and actions (A).
        show_indicators = "no";

        # The height of a single line.  If the height is smaller than the
        # font height, it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = 3;

        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        # separator_color = "frame";
        # Mouse
        # Left click
        mouse_left_click = "do_action";
        # Middle click
        mouse_middle_click = "close_current";
        # Right click
        mouse_right_click = "close_current";

        frame_width = 2;
        # frame_color = "#${palette.base0D}";
        corner_radius = 5;
      };
      urgency_low = {
        # background = "#${palette.base00}80";
        # foreground = "#${palette.base05}";
      };
      urgency_normal = {
        # background = "#${palette.base00}80";
        # foreground = "#${palette.base05}";
      };
      urgency_critical = {
        # background = "#${palette.base00}80";
        # foreground = "#${palette.base05}";
        # frame_color = "#${palette.base08}";
      };
    };
  };
}
