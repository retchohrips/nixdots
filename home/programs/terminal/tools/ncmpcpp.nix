{
  config,
  pkgs,
  ...
}: {
  programs.ncmpcpp = {
    enable = true;
    package =
      (pkgs.ncmpcpp.override
        {
          visualizerSupport = true;
        })
      .overrideAttrs (oldAttrs: {
        patches = [
          (pkgs.fetchpatch {
            # Add tag lyrics fetching
            url = "https://github.com/ncmpcpp/ncmpcpp/pull/482.patch";
            hash = "sha256-d+DkoUxm32vljxdrUStXfjinN3xJjzDlpNmMA3GyRTE=";
          })
        ];
      });
    mpdMusicDir = "${config.xdg.userDirs.music}";
    settings = {
      ignore_leading_the = "yes"; # Don't use "the" when sorting
      external_editor = "nvim";
      allow_for_physical_item_deletion = "no"; # Don't delete files from ncmpcpp

      # lyrics
      follow_now_playing_lyrics = "yes"; # Change lyrics when song changes
      lyrics_fetchers = "tags, azlyrics, genius, musixmatch";
      fetch_lyrics_for_current_song_in_background = "yes"; # Prevent lag when opening lyrics window

      connected_message_on_startup = "no";

      media_library_albums_split_by_date = "no";
      media_library_primary_tag = "album_artist";

      # visualizer
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_in_stereo = "no";
      visualizer_fps = "60";
      visualizer_type = "wave";
      visualizer_look = "∗▐";
      visualizer_color = "199,200,201,202,166,130,94,58,22";
      visualizer_spectrum_smooth_look = "yes";
      visualizer_autoscale = "yes";

      # general
      cyclic_scrolling = "yes";
      mouse_support = "yes";
      mouse_list_scroll_whole_page = "yes";
      lines_scrolled = "1";
      message_delay_time = "1";
      playlist_shorten_total_times = "yes";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      user_interface = "classic";
      locked_screen_width_part = "50";
      ask_for_locked_screen_width_part = "yes";
      display_bitrate = "no";
      main_window_color = "default";
      startup_screen = "playlist";

      # progress bar
      progressbar_look = "━━━";
      #progressbar_look = "▃▃▃";
      progressbar_elapsed_color = "5";
      progressbar_color = "black";

      # ui visibility
      header_visibility = "no";
      statusbar_visibility = "yes";
      titles_visibility = "yes";
      enable_window_title = "yes";

      # colors
      statusbar_color = "white";
      color1 = "white";
      color2 = "blue";

      # ui appearance
      now_playing_prefix = "$b$2$7 ";
      now_playing_suffix = "  $/b$8";
      current_item_prefix = "$b$7$/b$3 ";
      current_item_suffix = "  $8";

      song_columns_list_format = "(50)[]{t|fr:Title} (0)[magenta]{a}";

      song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8";

      song_status_format = "{{%a{ $2//$9 %b{, %y}} $2//$9 }{%t$/b}}|{$b%f$/b}";

      ## Note: You can choose default search mode for search engine. Available modes
      ## are:
      ##
      ## - 1 - use mpd built-in searching (no regexes, pattern matching)
      ##
      ## - 2 - use ncmpcpp searching (pattern matching with support for regexes, but
      ##       if your mpd is on a remote machine, downloading big database to process
      ##       it can take a while
      ##
      ## - 3 - match only exact values (this mode uses mpd function for searching in
      ##       database and local one for searching in current playlist)
      ##
      #
      search_engine_default_search_mode = 2;
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
