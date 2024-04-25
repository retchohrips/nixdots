{
  lib,
  config,
  ...
}: {
  services.bazarr = lib.mkIf config.modules.system.arr.enable {
    enable = true;
  };
}
