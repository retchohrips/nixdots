{
  imports = [./hardware.nix];
  config.modules.device = {
    type = "laptop";
    cpu.type = "intel";
  };
}
