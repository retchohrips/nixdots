{config, ...}: {
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "${config.home.homeDirectory}/Music";
    settings = {
      # Delays
      playlist_disable_highlight_delay = "2";
      message_delay_time = "1";

      ignore_leading_the = "yes";
      external_editor = "nvim";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      allow_for_physical_item_deletion = "no";
      lines_scrolled = "0";
      follow_now_playing_lyrics = "yes";
      lyrics_fetchers = "musixmatch";

      # visualizer
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_type = "ellipse";
      visualizer_look = "●● ";
      visualizer_color = "blue, green";

      # appearance
      colors_enabled = "yes";
      playlist_display_mode = "classic";
      user_interface = "classic";
      volume_color = "white";

      # window
      song_window_title_format = "Music";
      statusbar_visibility = "no";
      header_visibility = "no";
      titles_visibility = "no";

      media_library_primary_tag = "album_artist";
      connected_message_on_startup = "no";

      # progress bar
      progressbar_look = "‎‎‎";
      progressbar_color = "black";
      progressbar_elapsed_color = "blue";

      # song list
      song_status_format = "$7%t";
      song_list_format = "$(008)%t$R  $(247)%a$R$5  %l$8";
      song_columns_list_format = "(53)[blue]{tr} (45)[blue]{a}";

      current_item_prefix = "$b$2| ";
      current_item_suffix = "$/b$5";

      now_playing_prefix = "$b$5| ";
      now_playing_suffix = "$/b$5";

      song_library_format = "{{%a - %t} (%b)}|{%f}";

      # colors
      main_window_color = "blue";

      current_item_inactive_column_prefix = "$b$5";
      current_item_inactive_column_suffix = "$/b$5";

      color1 = "white";
      color2 = "blue";
    };
    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "J";
        command = ["select_item" "scroll_down"];
      }
      {
        key = "K";
        command = ["select_item" "scroll_up"];
      }
    ];
  };
}
