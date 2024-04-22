{
  lib,
  config,
  ...
}: let
  inherit (lib) mkDefault;
  acceptedTypes = ["laptop"];
in {
  config = lib.mkIf (builtins.elem config.modules.device.type acceptedTypes) {
    # no font config on a server since there shouldn't really BE fonts
    fonts.fontconfig.enable = mkDefault false;

    modules.system = {
      printing.enable = mkDefault false;
      bluetooth.enable = mkDefault false;
    };
  };
}
