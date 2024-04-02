{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.modules = {
    device = {
      type = mkOption {
        type = types.enum ["laptop" "desktop"];
        default = "";
        description = ''
          The type/purpose of the device that will be used within the rest of the configuration.
            - laptop: portable devices with batter optimizations
            - desktop: stationary devices configured for maximum performance
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
            The manifaturer/type of the primary system CPU.

            Determines which ucode services will be enabled and provides additional kernel packages
          '';
        };
      };
    };
    system.boot = {
      enableKernelTweaks = mkOption {
        type = types.bool;
        default = true;
        description = "security and performance related kernel parameters";
      };
      silentBoot = mkOption {
        type = types.bool;
        default = true;
        description = "almost entirely silent boot process through `quiet` kernel parameter";
      };
    };
  };
}
