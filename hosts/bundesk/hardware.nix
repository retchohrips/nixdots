{
  modulesPath,
  lib,
  config,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = [];
    };

    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/71f9cfec-82d6-439b-8a43-158c33b41d52";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd"
        # "noatime"
      ];
    };

    # TODO: make this actually work by booting from usb and creating proper subvolumes: https://nixos.wiki/wiki/Btrfs

    #"/nix" = {
    #  device = "/dev/disk/by-uuid/71f9cfec-82d6-439b-8a43-158c33b41d52";
    #  fsType = "btrfs";
    #  options = ["subvol=nix" "compress=zstd" "noatime"];
    #};

    #"/home" = {
    #  device = "/dev/disk/by-uuid/71f9cfec-82d6-439b-8a43-158c33b41d52";
    #  fsType = "btrfs";
    #  options = ["subvol=home" "compress=zstd" "noatime"];
    #};

    #"/var/log" = {
    #  device = "/dev/disk/by-uuid/71f9cfec-82d6-439b-8a43-158c33b41d52";
    #  fsType = "btrfs";
    #  options = ["subvol=log" "compress=zstd" "noatime"];
    #};

    "/boot" = {
      device = "/dev/disk/by-uuid/3C6F-6984";
      fsType = "vfat";
    };

    "/mnt/Cass" = {
      device = "/dev/disk/by-label/CASS";
      fsType = "btrfs";
      options = ["rw" "noatime" "nofail" "compress=zstd"];
    };

    "/mnt/Cart" = {
      device = "/dev/disk/by-label/CART";
      options = ["rw" "noatime" "nofail"];
    };

    "/mnt/Win".device = "/dev/nvme0n1p2";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
