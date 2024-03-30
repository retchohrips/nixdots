{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 5;
      blur = {
        enabled = true;
        special = true;
        popups = true;
        ignore_opacity = true;
        new_optimizations = true;
        xray = false;
        size = 4;
        passes = 4;
        contrast = 1.2;
        brightness = 1;
        vibrancy = 1;
        noise = 2.0e-2;
      };

      drop_shadow = true;
      shadow_range = 10;
      shadow_render_power = 3;
    };

    animations = {
      enabled = true;
      first_launch_animation = true;

      bezier = [
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
        "overshot, 0.4,0.8,0.2,1.2"
      ];

      animation = [
        "windows, 1, 4, overshot, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "border,1,10,default"

        "fade, 1, 10, smoothIn"
        "fadeDim, 1, 10, smoothIn"
        "workspaces,1,4,overshot,slidevert"
      ];
    };
  };
}
