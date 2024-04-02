{
  imports = [./hardware.nix];
  modules = {
    device = {
      type = "desktop";
      gpu.type = "amd";
      cpu.type = "intel";
    };
    system.virtualization = {
      enable = true;
      docker = {
        enable = true;
        tdarr-node.enable = true;
      };
    };
  };
}
