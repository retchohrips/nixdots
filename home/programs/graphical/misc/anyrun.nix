{
  inputs,
  pkgs,
  config,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.anyrun.homeManagerModules.default];
  programs.anyrun = lib.mkIf osConfig.programs.hyprland.enable {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        rink
        symbols
        translate
      ];

      # Position of the runner
      y.fraction = 0.02;

      # Hide match and plugin info icons
      hideIcons = false;

      # ignore exclusive zones, i.e. Waybar
      ignoreExclusiveZones = false;

      # Layer shell layer: Background, Bottom, Top, Overlay
      layer = "overlay";

      # Hide the plugin info panel
      hidePluginInfo = false;

      # Close window when a click outside the main box is received
      closeOnClick = true;

      # Show search results immediately when Anyrun starts
      showResultsImmediately = false;

      # Limit amount of entries shown in total
      maxEntries = 10;
    };

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          // Also show the Desktop Actions defined in the desktop files, e.g. "New Window" from Firefox
          desktop_actions: false,
          max_entries: 10,
          // The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
          // to determine what terminal to use.
          terminal: Some("kitty"),
        )
      '';

      "dictionary.ron".text = ''
        Config(
          prefix: ":def",
          max_entries: 5,
        )
      '';

      "symbols.ron".text = ''
        Config(
          // The prefix that the search needs to begin with to yield symbol results
          prefix: ":sy",

          // Custom user defined symbols to be included along the unicode symbols
          symbols: {
            // "name": "text to be copied"
            "shrug": "¯\\_(ツ)_/¯",
          },

          // The number of entries to be displayed
          max_entries: 5,
        )
      '';

      "translate.ron".text = ''
        Config(
          prefix: ":tr",
          language_delimiter: ">",
          max_entries: 3,
        )
      '';
    };

    extraCss = with config.lib.stylix.colors;
    /*
    css
    */
      ''
        :root {
          --rgba-color: rgba(${base07-rgb-r}, ${base07-rgb-g}, ${base07-rgb-b}, 0.7);
        }

        * {
          transition: 200ms ease;
          font-family: ${config.stylix.fonts.sansSerif.name};
          font-size: 1.3rem;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
        	background: transparent;
        }

        #match:selected {
          background: var(--rgba-color);
        }

        #match {
          padding: 3px;
          border-radius: 16px;
        }

        #entry,
        #plugin:hover {
          border-radius: 16px;
        }

        box#main {
          background: ${withHashtag.base00};
          border: 1px solid ${withHashtag.base02};
          border-radius: 16px;
          padding: 8px;
        }
      '';
  };
}
