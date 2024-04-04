{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    powerOnBoot = true;
    settings = {
      General = {
        JustWorksRepairing = "always";
        MultiProfile = "multiple";
        Experimental = true;
      };
    };
  };

  boot.kernelParams = [
    "bluetooth"
    "btusb"
  ];

  services.blueman.enable = true;
}
