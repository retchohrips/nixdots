{
  # discard blocks that are not in use by the filesystem, good for SSDs
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # tweak fstim service to run only when on AC power
  # and to be nice to other processes
  # (this is a good idea for any service that runs periodically)
  systemd.services.fstrim = {
    unitConfig.ConditionACPower = true;

    serviceConfig = {
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };
}
