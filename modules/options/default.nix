{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.modules = {
    device = {
      type = mkOption {
        type = types.enum ["laptop" "desktop" "server"];
        default = "";
        description = ''
          The type/purpose of the device that will be used within the rest of the configuration.
            - laptop: portable devices with battery optimizations
            - desktop: stationary devices configured for maximum performance
            - server: minimal config with no gui
        '';
      };

      gpu = {
        type = mkOption {
          type = with types; nullOr (enum ["amd" "intel"]);
          default = null;
          description = ''
            The manufacturer/type of the primary system GPU. Allows the correct GPU drivers to be loaded.
          '';
        };
      };

      cpu = {
        type = mkOption {
          type = with types; nullOr (enum ["intel"]);
          default = null;
          description = ''
            The manifaturer/type of the primary system CPU. Determines which ucode services will be enabled and provides additional kernel packages.
          '';
        };
      };
    };

    system = {
      hostname = mkOption {
        type = types.str;
        description = "Hostname";
      };

      bluetooth = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable bluetooth";
        };
      };

      arr.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable media server.";
      };

      printing = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable printing";
        };
      };

      boot = {
        enableKernelTweaks = mkOption {
          type = types.bool;
          default = true;
          description = "Security and performance related kernel parameters";
        };

        silentBoot = mkOption {
          type = types.bool;
          default = true;
          description = "Almost entirely silent boot process through `quiet` kernel parameter";
        };
      };
    };

    home = {
      theme = mkOption {
        type = types.str;
        default = "catppuccin-frappe";
        description = "The theme to use for stylix. Should be a base-16 theme.";
      };

      wallpaper = {
        file = mkOption {
          type = types.path;
          default = ../../wallpapers/flowers.png;
          description = "Image to use for wallpaper.";
        };

        generate = mkOption {
          type = types.bool;
          default = true;
          description = "Use lutgen to modify the wallpaper file to fit the stylix color theme.";
        };
      };
    };
  };
}
