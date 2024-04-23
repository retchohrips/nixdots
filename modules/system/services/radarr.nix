{
  lib,
  config,
  ...
}: {
  services.radarr = lib.mkIf config.modules.system.arr.enable {
    enable = true;
  };
}
