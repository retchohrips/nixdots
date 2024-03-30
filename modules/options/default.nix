{lib, ...}: let
  inherit (lib) mkOption mkEnableOption mkDefault types;
in {
  options.modules.device = {
    type = mkOption {
      type = types.enum ["laptop" "desktop"];
      default = "";
      description = ''
        The type/purpose of the device that will be used within the rest of the configuration.
          - laptop: portable devices with batter optimizations
          - desktop: stationary devices configured for maximum performance
      '';
    };
  };

  config.modules = {
    system.boot = {
      enableKernelTweaks = mkDefault true;
      silentBoot = mkDefault true;
    };
  };
}
