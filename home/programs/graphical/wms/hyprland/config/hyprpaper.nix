{config, ...}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.stylix.image}
    wallpaper = ,${config.stylix.image}
    splash = false
  '';

  wayland.windowManager.hyprland.settings.exec-once = ["hyprpaper"];
}
