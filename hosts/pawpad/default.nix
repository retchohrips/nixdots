{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  services.fwupd.enable = true;
}
