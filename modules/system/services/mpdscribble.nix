{
  config,
  lib,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  services.mpdscribble = lib.mkIf (builtins.elem config.modules.device.type acceptedTypes) {
    enable = true;
    endpoints = {
      "last.fm" = {
        username = "cryptidrabbit";
        passwordFile = config.age.secrets.lastfm-account.path;
      };
    };
  };
}
