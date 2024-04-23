{
  lib,
  config,
  ...
}: {
  services.prowlarr = lib.mkIf config.modules.system.arr.enable {
    enable = true;
  };
}
