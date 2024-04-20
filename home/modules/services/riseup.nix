{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.modules.system.vpn.enable {
    systemd.user.services.riseup-configure = {
      Unit.Description = "riseup vpn configuration";

      Service = {
        Type = "oneshot";
        ExecStart = "riseup-configure";
      };
    };

    systemd.user.timers.riseup-configure = {
      Unit = {Description = "Timer for riseup vpn configuration";};

      Timer = {
        OnUnitActiveSec = "1w";
        Unit = "riseup-configure.service";
      };

      Install = {WantedBy = ["timers.target"];};
    };
  };
}
