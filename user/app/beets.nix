{
  config,
  pkgs,
  ...
}: {
  programs.beets = {
    enable = true;
    package = pkgs.beets-unstable;
    mpdIntegration.enableUpdate = true;
    settings = {
      directory = "${config.home.homeDirectory}/Music";
      library = "${config.home.homeDirectory}/Music/library.db";
      import = {
        move = true;
        incremental = true;
      };
      plugins = [
        # "bandcamp"
        "chroma"
        # "discogs"
        "edit"
        "embedart"
        "fetchart"
        "lyrics"
        "replaygain"
        "the"
        "fish"
        "smartplaylist"
        "lastgenre"
        "convert"
        "missing"
        "info"
        "albumtypes"
        "mpdupdate"
        "rewrite"
      ];
      fetchart = {
        sources = [
          "filesystem"
          "itunes"
          "amazon"
          "lastfm"
          "spotify"
          # "bandcamp"
          "wikipedia"
          "coverart"
          "albumart"
        ];
      };
      lyrics = {
        auto = true;
        sources = "*";
      };
      replaygain = {
        auto = true;
        backend = "ffmpeg";
      };
      convert = {
        auto = true;
        delete_originals = true;
        never_convert_lossy_files = true;
      };
      albumtypes = {
        types = [
          {ep = "EP";}
          {single = "Single";}
          {soundtrack = "OST";}
          {live = "Live";}
          {compilation = "Anthology";}
        ];
        ignore_va = "compilation";
        bracket = "[]";
      };
      rewrite = {
        "artist 𝐞𝐭𝐡𝐞𝐥 𝐜𝐚𝐢𝐧.*" = "Ethel Cain";
      };
      smartplaylist = {
        relative_to = "${config.home.homeDirectory}/Music";
        playlist_dir = "${config.home.homeDirectory}/Music/Playlists";

        playlists = [
          {
            name = "4lung.m3u";
            query = "albumartist::(4lung|rawrdcore|'Bleak Fortune'|'Blueberry Sunshine'|Dalmatrix|minxmax|P9|'Rat King World Champion'|'Yo-Yo Bingo')";
          }
        ];
      };
      paths = {
        comp = "Various Artists/$album [$year]$atypes/$track $title";
        singleton = "%the{$artist}/[$year][Single] $title/$title";
        default = "%the{$albumartist}/[$year]$atypes $album/$track $title";
      };
    };
  };

  home.packages = with pkgs; [
    chromaprint
    gst_all_1.gstreamer
    (pkgs.python3.withPackages (ps:
      with ps; [
        # discogs-client
        pyacoustid
        requests
        beautifulsoup4
      ]))
  ];
}
