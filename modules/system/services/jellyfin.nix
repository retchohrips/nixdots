{
  lib,
  config,
  ...
}: {
  services.jellyfin = lib.mkIf config.modules.system.arr.enable {
    enable = true;
  };
}
