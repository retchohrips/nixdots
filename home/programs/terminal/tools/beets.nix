{
  config,
  pkgs,
  systemSettings,
  inputs,
  ...
}: {
  home.file."lastloved" = {
    target = ".config/beets/plugins/lastloved";
    source = inputs.beets-lastloved;
  };
  programs.beets = {
    enable = true;
    # package = pkgs.beets-unstable;
    mpdIntegration.enableUpdate = true;
    settings = {
      directory =
        if (systemSettings.hostname == "bundesk")
        then "/mnt/Cass/Music"
        else "${config.xdg.userDirs.music}";
      library = "${config.home.homeDirectory}/.beets/library.db";
      import = {
        move = true;
        incremental = true;
      };
      asciify_paths = true;
      paths = {
        default = "%the{$albumartist}/%if{year, [$year]} $album/$track $title";
        comp = "Compilations/$album %if{year, [$year]}/$track $title";
        singleton = "%the{$artist}/Singles/%if{year, [$year]} $title";
      };
      match.max_rec = {
        # Don't rate media that differs from our guess with anymore than medium confidence
        media = "medium";
        unmatched_tracks = "medium";
      };
      musicbrainz = {
        # genres = true; # conflicts with lastgenre
        extra_tags = ["year"];

        searchlimit = 10;
      };
      pluginpath = ["~/.config/beets/plugins/lastloved/beetsplug"];
      plugins = [
        "lastloved"
        "chroma"
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
        "info"
        "mpdupdate"
        "rewrite"
        "spotify"
        "zero"
      ];
      lastfm.user = "cryptidrabbit";
      fetchart = {
        auto = true;

        cautious = true;
        high_resolution = true;

        enforce_ratio = "0.5%";

        cover_names = ["cover" "front" "art" "album" "folder"];

        sources = [
          "filesystem"
          # "bandcamp"
          {coverart = "release releasegroup";}
          "spotify"
          "itunes"
          "amazon"
        ];
      };
      lastgenre = {
        auto = true;
        separator = ";";
        count = 5;
        prefer_specific = true;
        title_case = false;
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
      zero = {
        auto = true;
        fields = ["genre"];
        update_database = true;
      };
      rewrite = {
        "artist 𝐞𝐭𝐡𝐞𝐥 𝐜𝐚𝐢𝐧.*" = "Ethel Cain";
        "albumartist Atlas feat\. Fats.e" = "Atlas";
      };
      smartplaylist = {
        auto = true;
        relative_to =
          if (systemSettings.hostname == "bundesk")
          then "/mnt/Cass/Music"
          else "${config.xdg.userDirs.music}";
        playlist_dir = "${config.xdg.userDirs.music}/Playlists";

        playlists = [
          {
            name = "4lung.m3u";
            query = "albumartist::(4lung|rawrdcore|'Bleak Fortune'|'Blueberry Sunshine'|Dalmatrix|minxmax|P9|'Rat King World Champion'|'Yo-Yo Bingo')";
          }
          {
            name = "nicolethel.m3u";
            query = "albumartist::('Nicole Dollanganger'|'Ethel Cain')";
          }
          {
            name = "loved.m3u";
            query = "loved:1";
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    nicotine-plus
    chromaprint
    gst_all_1.gstreamer
    (pkgs.python3.withPackages (ps:
      with ps; [
        pyacoustid
        pylast
        requests
        beautifulsoup4
      ]))
  ];
}
