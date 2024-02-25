{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # DNS and firewall. Majorly slows down laptop.
    ../../system/security/networking.nix
  ];

  fileSystems = {
    "/mnt/Hardy".device = "/dev/disk/by-label/Hardy";
    "/mnt/Harvey".device = "/dev/disk/by-label/Harvey";
    "/mnt/Win".device = "/dev/nvme0n1p2";
  };
}
