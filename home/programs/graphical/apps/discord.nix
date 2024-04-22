{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  config = lib.mkIf (builtins.elem osConfig.modules.device.type acceptedTypes) {
    home.packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
  };
}
