{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  config = lib.mkIf (builtins.elem osConfig.modules.device.type acceptedTypes) {
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

        search = let
          updateInterval = 24 * 60 * 60 * 1000;
        in {
          force = true;
          default = "Brave";
          engines = {
            "Brave" = {
              urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
              iconUpdateURL = "https://brave.com/static-assets/images/brave-favicon.png";
              inherit updateInterval;
              definedAliases = ["@b"];
            };

            "Startpage" = {
              urls = [{template = "https://www.startpage.com/search?q={searchTerms}";}];
              iconUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon--default.ico";
              inherit updateInterval;
              definedAliases = ["@s"];
            };

            "GitHub" = {
              urls = [{template = "https://github.com/search?q={searchTerms}&type=code";}];
              iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
              inherit updateInterval;
              definedAliases = ["@gh"];
            };

            "YouTube" = {
              urls = [{template = "https://youtube.com/results?search_query={searchTerms}";}];
              iconUpdateURL = "https://youtube.com/favicon.ico";
              inherit updateInterval;
              definedAliases = ["@yt"];
            };

            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "Home-Manager" = {
              urls = [{template = "https://rycee.gitlab.io/home-manager/options.html";}];
              definedAliases = ["@hm"];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://wiki.nixos.org/wiki/{searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nw"];
            };

            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Google".metaData.alias = "@g";
            "DuckDuckGo".metaData.alias = "@d";
            "Wikipedia (en)".metaData.alias = "@wiki";
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
  };
}
