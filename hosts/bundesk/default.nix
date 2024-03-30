{
  imports = [./hardware.nix];
  modules = {
    device.type = "desktop";
    system.virtualization = {
      enable = true;
      docker = {
        enable = true;
        tdarr-node.enable = true;
      };
    };
  };
}
