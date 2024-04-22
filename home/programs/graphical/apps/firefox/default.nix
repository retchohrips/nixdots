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

        search = {
          force = true;
          default = "Brave";
          engines = let
            icons = pkgs.nixos-icons + "/share/icons/hicolor/scalable/apps";
            engine = {
              search,
              definedAliases ? [],
              icon ? null,
              iconUpdateURL ? null,
            }: {
              inherit icon iconUpdateURL definedAliases;
              urls = [{template = search;}];
              updateInterval = 24 * 60 * 60 * 1000;
            };
          in {
            "Brave" = engine {
              search = "https://search.brave.com/search?q={searchTerms}";
              iconUpdateURL = "https://brave.com/static-assets/images/brave-favicon.png";
              definedAliases = ["@b"];
            };

            "Startpage" = engine {
              search = "https://www.startpage.com/search?q={searchTerms}";
              iconUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon--default.ico";
              definedAliases = ["@s"];
            };

            "GitHub" = engine {
              search = "https://github.com/search?q={searchTerms}&type=code";
              iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
              definedAliases = ["@gh"];
            };

            "YouTube" = engine {
              search = "https://youtube.com/results?search_query={searchTerms}";
              iconUpdateURL = "https://youtube.com/favicon.ico";
              definedAliases = ["@yt"];
            };

            "Nix Packages" = engine {
              search = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              icon = icons + "/nix-snowflake.svg";
              definedAliases = ["@np" "@nixp" "@nix-packages"];
            };

            "Home Manager Options" = let
              base_url = "https://mipmip.github.io/home-manager-option-search";
            in
              engine {
                search = "${base_url}/?query={searchTerms}";
                icon = icons + "/nix-snowflake-white.svg";
                definedAliases = ["@hm" "@home-manager"];
              };

            "NixOS Options" = engine {
              search = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
              icon = icons + "/nix-snowflake-white.svg";
              definedAliases = ["@no" "@nixo" "@nix-options"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://wiki.nixos.org/wiki/{searchTerms}";}];
              icon = icons + "/nix-snowflake.svg";
              definedAliases = ["@nw" "@nixw" "@nix-wiki"];
            };

            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "eBay".metaData.hidden = true;
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
