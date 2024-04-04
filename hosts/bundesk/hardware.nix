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
      device = "/dev/disk/by-uuid/39f2d6a1-f221-4074-8768-acf5db5f7425";
      fsType = "ext4";
    };

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
