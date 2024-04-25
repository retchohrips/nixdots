{userSettings, ...}: {
  imports = [./hardware.nix];

  modules = {
    device = {
      type = "desktop";
      gpu.type = "amd";
      cpu.type = "intel";
    };
    system = {
      hostname = "bundesk";
      vpn.enable = true;
      arr.enable = true;
      virtualization = {
        enable = true;
        virt.enable = true;
      };
    };
  };

  system.activationScripts.linktomusic.text =
    /*
    bash
    */
    ''
      if [[ ! -h "/home/${userSettings.username}/Media/Music" ]]; then
        ln -s "/mnt/Cass/Media/Music" "/home/${userSettings.username}/Media/Music"
      fi
    '';
}
