{
  inputs,
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  stylix.image = ../../wallpapers/Makima_Persona.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.targets.rofi.enable = false;
  stylix.targets.waybar.enable = false;
}
