{inputs, ...}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      name = "Default";
      extraConfig = builtins.readFile inputs.betterfox;

      settings = {
        "extensions.abuseReport.enabled" = false;
        "browser.search.suggest.enabled" = true;

        "browser.uidensity" = 1;

        # Scrolling (https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js)
        "apz.overscroll.enabled" = true;
        "general.smoothScroll" = true;
        "mousewheel.default.delta_multiplier_y" = 275;
      };

      search = {
        force = true;
        default = "Startpage";
        engines = {
          "Startpage" = {
            urls = [{template = "https://www.startpage.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon--default.ico";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@s"];
          };
          "GitHub" = {
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];

            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "YouTube" = {
            iconUpdateURL = "https://youtube.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@yt"];
            urls = [
              {
                template = "https://youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };

      userChrome =
        /*
        css
        */
        ''
          /* Remove close button */
          .titlebar-buttonbox-container{ display:none }
          .titlebar-spacer[type="post-tabs"]{ display:none }
        '';
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
}
