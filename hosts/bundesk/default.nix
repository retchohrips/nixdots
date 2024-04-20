{userSettings, ...}: {
  imports = [./hardware.nix];

  system.activationScripts.linktomusic.text =
    /*
    bash
    */
    ''
      if [[ ! -h "/home/${userSettings.username}/Media/Music" ]]; then
        ln -s "/mnt/Cass/Media/Music" "/home/${userSettings.username}/Media/Music"
      fi
    '';

  modules = {
    device = {
      type = "desktop";
      gpu.type = "amd";
      cpu.type = "intel";
    };
    system = {
      vpn.enable = true;
      virtualization = {
        enable = true;
        docker = {
          enable = true;
          tdarr-node.enable = true;
        };
        virt.enable = true;
      };
    };
  };
}
