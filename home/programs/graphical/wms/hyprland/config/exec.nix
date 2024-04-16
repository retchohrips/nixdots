{config, ...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
    "wl-paste --type text --watch cliphist store" # Stores only text data
    "wl-paste --type image --watch cliphist store" # Stores only image data
    "gnome-keyring-daemon --start --components=secrets"
    "waybar"
    "wlsunset-auto"
    "sleep 5 ; telegram-desktop -startintray ; discord --start-minimized"
  ];
}
