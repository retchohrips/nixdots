{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      font_size = 12;
      cursor_shape = "beam";
      window_padding_width = 15;
      window_margin_width = 10;
      confirm_os_window_close = 0;
      linux_display_server = "x11";
      # enabled_layouts = "grid, splits, tall, fat";
      disable_ligatures = "never";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      scrollback_lines = 10000;
      click_interval = "0.5";
      select_by_word_characters = ":@-./_~?&=%+#";
      remember_window_size = false;
      repaint_delay = 15;
      input_delay = 3;
      url_style = "double";
      open_url_with = "default";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+alt+c" = "copy_to_clipboard";
      "ctrl+alt+v" = "paste_from_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      "ctrl+shift+up" = "increase_font_size";
      "ctrl+shift+down" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";

      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+w" = "close_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";

      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";
    };
  };

  programs.git.extraConfig = {
    diff.tool = "kitty";
    diff.guitool = "kitty.gui";
    difftool.prompt = false;
    difftool.trustExitCode = true;
    "difftool \"kitty\"".cmd = "${pkgs.kitty}/bin/kitty +kitten diff $LOCAL $REMOTE";
    "difftool \"kitty.gui\"".cmd = "${pkgs.kitty}/bin/kitty kitty +kitten diff $LOCAL $REMOTE";
  };
}
