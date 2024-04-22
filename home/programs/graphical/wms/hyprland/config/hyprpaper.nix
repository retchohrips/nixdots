{
  config,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.modules.home.wallpaper != null && osConfig.programs.hyprland.enable) {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ${config.stylix.image}
      wallpaper = ,${config.stylix.image}
      splash = false
    '';

    wayland.windowManager.hyprland.settings.exec-once = ["hyprpaper"];
  };
}
