{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        vertical_alignment = "center";
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

        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_current";

        frame_width = 2;
        corner_radius = 5;
      };
    };
  };
}
