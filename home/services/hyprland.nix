{
  lib,
  osConfig,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hypridle.homeManagerModules.default
  ];
  config = lib.mkIf osConfig.programs.hyprland.enable {
    services.udiskie = {
      enable = true;
      tray = "auto";
    };

    services.gvfs.enable = true; # mount, trash, and stuff

    services.hypridle = {
      enable = true;
      lockCmd = "hyprlock";
      ignoreDbusInhibit = false;
      beforeSleepCmd = "hyprlock";

      listeners = [
        {
          timeout = 3 * 60;
          onTimeout = "hyprlock";
        }
        {
          timeout = (3 * 60) + 30;
          onTimeout = "${pkgs.coreutils}/bin/sleep 1 && hyprctl dispatch dpms off";
          onResume = "hyprctl dispatch dpms on";
        }
      ];
    };

    systemd.user.services.polkit-pantheon-authentication-agent-1 =
      # lib.mkGraphicalService {
      #   Service.ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
      # };
      {
        Unit = {
          Description = "Polkit Authentication Agent";
        };

        Service = {
          Type = "simple";
          ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
          Slice = "session.slice";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
  };
}
