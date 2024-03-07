{pkgs, ...}: {
  programs.floorp = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
      search = {
        default = "Perplexity";
        force = true;
        engines = {
          "Perplexity" = {
            urls = [
              {
                template = "https://www.perplexity.ai/search?focus=internet&copilot=true&q={searchTerms}";
              }
            ];
          };
          "MyNixOS" = {urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];};
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
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
          "Google".metaData.alias = "@g";
        };
      };
      settings = {
        "floorp.tabbar.style" = 2;
        "floorp.browser.tabbar.settings" = 2;
        "browser.display.statusbar" = true;
        "floorp.navbar.bottom" = true;
        "floorp.bookmarks.fakestatus.mode" = true;
        # Enable drm
        "media.eme.enabled" = true;

        "browser.search.region" = "US";
        "browser.search.isUS" = true;
        "distribution.searchplugins.defaultLocale" = "en-US";
        "general.useragent.locale" = "en-US";

        # Allow downloads from HTTP websites
        "dom.block_download_insecure" = false;

        # Always use XDG portals for stuff
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        "browser.EULA.override" = true;

        #speed
        "network.http.max-persistent-connections-per-server" = 30;
        "browser.cache.disk.enable" = false;
      };
    };
  };
}
