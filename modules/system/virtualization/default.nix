{lib, ...}: {
  imports = [./virt.nix];
  options.modules.system.virtualization = {
    enable = lib.mkEnableOption "virtualization";
    waydroid.enable = lib.mkEnableOption "waydroid";
    virt.enable = lib.mkEnableOption "virt";
  };
}
