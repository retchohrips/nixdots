{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    powerOnBoot = true;
  };

  services.blueman.enable = true;
}
