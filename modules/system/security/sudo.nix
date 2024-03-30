{lib, ...}: {
  security = {
    # disable the default incomplete sudo fork
    sudo-rs.enable = lib.mkForce false;
    sudo = {
      enable = true;

      # While convenient, this it insecure :(
      wheelNeedsPassword = lib.mkDefault false;

      #only allow members of the wheel group to execute sudo
      # by setting the executable’s permissions accordingly
      execWheelOnly = lib.mkForce true;

      extraConfig = ''
        Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
        Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
        Defaults env_keep += "EDITOR PATH DISPLAY" # variables that will be passed to the root account
        Defaults timestamp_timeout = 300 # makes sudo ask for password less often
      '';

      extraRules = [
        {
          groups = ["wheel"];
          commands = let
            currentSystem = "/run/current-system/";
            storePath = "/nix/store/";
          in [
            {
              # let wheel group collect garbage without password
              command = "${currentSystem}/sw/bin/nix-collect-garbage";
              options = ["SETENV" "NOPASSWD"];
            }
            {
              # let wheel group interact with systemd without password
              command = "${currentSystem}/sw/bin/systemctl";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };
  };
}
