{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # DNS and firewall. Majorly slows down laptop.
    # ../../system/security/networking.nix
    ../../system/docker.nix
  ];

  fileSystems = {
    "/mnt/Cass" = {
      device = "/dev/disk/by-label/CASS";
      options = ["rw" "noatime" "nofail"];
    };
    "/mnt/Cart" = {
      device = "/dev/disk/by-label/CART";
      options = ["rw" "noatime" "nofail"];
    };
    "/mnt/Win".device = "/dev/nvme0n1p2";
  };
}
