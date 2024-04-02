{lib, ...}: {
  imports = [
    ./bluetooth.nix
    ./cpu
    ./gpu
    ./sound.nix
    ./video.nix
  ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
