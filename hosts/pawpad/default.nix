{
  imports = [./hardware.nix];
  config = {
    modules = {
      system = {hostname = "pawpad";};
      device = {
        type = "laptop";
        cpu.type = "intel";
      };
      home = {wallpaper = {file = ../../wallpapers/Y2K.png;};};
    };
  };
}
