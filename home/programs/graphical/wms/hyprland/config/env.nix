{config, ...}: {
  wayland.windowManager.hyprland.settings.env = [
    "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
    "WLR_RENDERER_ALLOW_SOFTWARE,1"
    "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
  ];
}
