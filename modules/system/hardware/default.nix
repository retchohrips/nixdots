{lib, ...}: {
  imports = [
    ./bluetooth.nix
    ./gpu.nix
    ./sound.nix
    ./video.nix
  ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
