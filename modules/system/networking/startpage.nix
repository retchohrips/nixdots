{
  pkgs,
  userSettings,
  ...
}: {
  systemd.services.startpage = {
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
