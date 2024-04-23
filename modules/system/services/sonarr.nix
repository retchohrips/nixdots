{
  lib,
  config,
  ...
}: {
  services.sonarr = lib.mkIf config.modules.system.arr.enable {
    enable = true;
  };
}
