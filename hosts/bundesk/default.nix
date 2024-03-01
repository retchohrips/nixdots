{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # DNS and firewall. Majorly slows down laptop.
    ../../system/security/networking.nix
  ];

  fileSystems = {
    "/mnt/Cass".device = "/dev/disk/by-label/Cass";
    "/mnt/Cart".device = "/dev/disk/by-label/Cart";
    "/mnt/Win".device = "/dev/nvme0n1p2";
  };
}
