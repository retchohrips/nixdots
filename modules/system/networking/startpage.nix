{
  pkgs,
  userSettings,
  lib,
  config,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  systemd.services.startpage = lib.mkIf (builtins.elem config.modules.device.type acceptedTypes) {
    description = "A simple static homepage.";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.caddy}/bin/caddy file-server --listen localhost:6781 --root /home/${userSettings.username}/.dotfiles/home/programs/graphical/apps/firefox
      '';
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
