{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  acceptedTypes = ["laptop" "desktop"];
in {
  config = lib.mkIf (builtins.elem osConfig.modules.device.type acceptedTypes) {
    home.packages = with pkgs;
      [
        (lutris.override {
          extraPkgs = pkgs: [
            gnome.zenity
            pixman
            libjpeg
          ];
        })
        prismlauncher # Minecraft
        protontricks
        gnome.zenity
      ]
      ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
        winetricks
      ]);
  };
}
