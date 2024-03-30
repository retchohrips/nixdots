{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];

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
}
