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
      device = "/dev/disk/by-partlabel/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-partlabel/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
        "noatime"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-partlabel/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
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
