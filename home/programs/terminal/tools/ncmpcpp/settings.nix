{config, ...}: {
  programs.ncmpcpp.settings = {
    # misc
    ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
    connected_message_on_startup = false;
    external_editor = "nvim";
    message_delay_time = 1;
    playlist_disable_highlight_delay = 2;
    allow_for_physical_item_deletion = false; # Don't delete files from ncmpcpp, use beets instead
    lines_scrolled = 0;
    mouse_support = true;

    # lyrics
    follow_now_playing_lyrics = true;
    lyrics_fetchers = "tags, azlyrics, genius, musixmatch";
    fetch_lyrics_for_current_song_in_background = true; # Prevent lag when opening lyrics window

    # visualizer
    visualizer_data_source = "/tmp/mpd.fifo";
    visualizer_output_name = "mpd_visualizer";
    visualizer_type = "ellipse";
    visualizer_look = "●● ";
    visualizer_color = "blue, green";

    # appearance
    playlist_display_mode = "classic";
    user_interface = "alternative";
    autocenter_mode = true;
    centered_cursor = true;
    playlist_shorten_total_times = true;

    # window
    statusbar_visibility = false;
    header_visibility = false;
    titles_visibility = false;
    enable_window_title = true;

    # general
    locked_screen_width_part = "50";
    ask_for_locked_screen_width_part = "yes";
    display_bitrate = "no";
    startup_screen = "playlist";

    # progress bar
    progressbar_look = "---";
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

    song_library_format = "{%t}|{%f}";

    # colors
    colors_enabled = true;
    volume_color = "white";
    main_window_color = "blue";
    current_item_inactive_column_prefix = "$b$5";
    current_item_inactive_column_suffix = "$/b$5";
    color1 = "white";
    color2 = "blue";

    # sorting / searching
    ignore_leading_the = true;
    media_library_albums_split_by_date = "no";
    media_library_primary_tag = "album_artist";

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
}
