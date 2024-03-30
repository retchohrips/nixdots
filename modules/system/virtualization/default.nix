{lib, ...}: {
  imports = [./docker];
  options.modules.system.virtualization = {
    enable = lib.mkEnableOption "virtualization";
    docker = {
      enable = lib.mkEnableOption "docker";
      tdarr-node.enable = lib.mkEnableOption "tdarr-node";
    };
    waydroid = {enable = lib.mkEnableOption "waydroid";};
  };
}