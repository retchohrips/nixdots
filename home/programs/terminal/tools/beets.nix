{
  config,
  pkgs,
  systemSettings,
  ...
}: let
  beetcamp = pkgs.callPackage ({
    lib,
    fetchFromGitHub,
    beets,
    python3Packages,
  }:
    python3Packages.buildPythonApplication rec {
      pname = "beetcamp";
      version = "0.17.2";
      pyproject = true;

      src = fetchFromGitHub {
        repo = pname;
        owner = "snejus";
        rev = version;
        hash = "sha256-qvfNo92NeDa5F7bV+zgMCan4CMIF38oyuJFsmRp+J4g=";
      };

      propagatedBuildInputs = with python3Packages; [
        poetry-core
        ordered-set
        pycountry
        requests
      ];

      nativeBuildInputs = [beets];

      meta = with lib; {
        description = "Use Bandcamp as a autotagger source for beets";
        homepage = "https://github.com/snejus/beetcamp";
        maintainers = with maintainers; [retchohrips];
        license = licenses.gpl2;
      };
    })
  {beets = pkgs.beetsPackages.beets-minimal;};
  lastloved =
    pkgs.callPackage
    (
      {
        lib,
        fetchFromGitHub,
        beets,
        python3Packages,
      }:
        python3Packages.buildPythonApplication rec {
          pname = "beets-lastloved";
          version = "main";
          pyproject = true;

          src = fetchFromGitHub {
            repo = pname;
            owner = "retchohrips";
            rev = version;
            hash = "sha256-K4fyFNYjXAmDsVwQh1mUwKp58AOsWwjnOPdIY4N4m7c=";
          };

          # there are no tests
          doCheck = false;

          nativeBuildInputs = [beets];

          propagatedBuildInputs = with python3Packages; [
            poetry-core
            pylast
          ];

          meta = with lib; {
            description = "Plugin for beets to import loved tracks from last.fm.";
            homepage = "https://github.com/retchohrips/beets-LastLoved";
            maintainers = with maintainers; [retchohrips];
            inherit (beets.meta) platforms;
          };
        }
    )
    {beets = pkgs.beetsPackages.beets-minimal;};
in {
  programs.beets = {
    enable = true;
    package = pkgs.beets.override {
      pluginOverrides = {
        beetcamp = {
          enable = true;
          propagatedBuildInputs = [beetcamp];
        };
        lastloved = {
          enable = true;
          propagatedBuildInputs = [lastloved];
        };
      };
    };
    mpdIntegration.enableUpdate = true;
    settings = {
      directory =
        if (systemSettings.hostname == "bundesk")
        then "/mnt/Cass/Media/Music"
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
      plugins = [
        "zero"
        "scrub"
        "lastloved"
        "bandcamp"
        "spotify"
        "lastgenre"
        "chroma"
        "edit"
        "fetchart"
        "embedart"
        "lyrics"
        "replaygain"
        "the"
        "fish"
        "smartplaylist"
        "convert"
        "info"
        "mpdupdate"
        "rewrite"
      ];
      lastfm.user = "cryptidrabbit";
      bandcamp = {
        art = true;
        exclude_extra_fields = ["comments"];
        genre = {
          capitalize = true;
        };
      };
      fetchart = {
        auto = true;

        cautious = true;
        high_resolution = true;

        enforce_ratio = "0.5%";

        cover_names = ["cover" "front" "art" "album" "folder"];

        sources = [
          "filesystem"
          "bandcamp"
          {coverart = "release releasegroup";}
          "spotify"
          "itunes"
          "amazon"
        ];
      };
      lastgenre = {
        auto = true;
        separator = ";";
        canonical = true;
        count = 2;
        title_case = true;
      };
      zero = {
        auto = true;
        fields = ["albumtype" "albumtypes" "comments"];
        update_database = true;
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
      rewrite = {
        "artist 𝐞𝐭𝐡𝐞𝐥 𝐜𝐚𝐢𝐧.*" = "Ethel Cain";
        "albumartist Atlas feat\. Fats.e" = "Atlas";
      };
      smartplaylist = {
        auto = true;
        relative_to =
          if (systemSettings.hostname == "bundesk")
          then "/mnt/Cass/Media/Music"
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
