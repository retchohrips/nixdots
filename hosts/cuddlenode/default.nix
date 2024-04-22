{
  # imports = [./hardware.nix];

  modules = {
    device = {
      type = "server";
      cpu.type = "intel";
    };
    system = {
      hostname = "cuddlenode";
      vpn.enable = true;
    };
  };
}
