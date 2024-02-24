{
  config,
  pkgs,
  ...
}: {
  programs.beets = {
    enable = true;
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
      ];
      fetchart = {
        sources = [
          "filesystem"
          "coverart"
          "itunes"
          "amazon"
          "albumart"
          "spotify"
          # "bandcamp"
          "wikipedia"
        ];
      };
      replaygain = {backend = "gstreamer";};
      convert = {
        auto = true;
        delete_originals = true;
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
      ]))
  ];
}
