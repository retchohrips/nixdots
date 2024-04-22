{
  lib,
  config,
  inputs,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  # Servers don't need sound
  config = lib.mkIf (builtins.elem config.modules.device.type acceptedTypes) {
    sound = {
      enable = lib.mkDefault false; # This just enables ALSA??
      mediaKeys.enable = true;
    };

    # Enable RealtimeKit if pipewire is enabled
    security.rtkit.enable = config.services.pipewire.enable;

    services.pipewire = {
      enable = true; # emulation layers
      audio.enable = true;
      pulse.enable = true; # PA server emulation
      jack.enable = true; # JACK audio emulation
      alsa = {
        enable = true;
        support32Bit = true;
      };

      lowLatency.enable = true;
    };

    systemd.user.services = {
      pipewire.wantedBy = ["default.target"];
      pipewire-pulse.wantedBy = ["default.target"];
    };
  };
}
