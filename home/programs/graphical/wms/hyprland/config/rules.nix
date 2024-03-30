{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, ^Rofi"
      "tile, ^(kitty)$"
    ];

    windowrulev2 = [
      # only allow shadows for floating windows
      "noshadow, floating:0"

      "float,class:udiskie"

      # Telegram media viewer
      "float, title:^(Media viewer)$"

      # wlogout
      "fullscreen,class:wlogout"
      "fullscreen,title:wlogout"
      "noanim, title:wlogout"

      # Make steam menus stay put
      "stayfocused, title:^()$,class:^(steam)$"
      "minsize 1 1, title:^()$,class:^(steam)$"

      "float, class:(firefox|floorp), title:^(Extension: \(Bitwarden - Free Password Manager\))"

      # pip browser
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
    ];

    layerrule = [
      "blur, waybar$"
      "ignorezero, rofi$"
      "blur, rofi$"
      "blur, notifications$"
      "ignorezero, notifications$"
    ];
  };
}