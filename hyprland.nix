{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [];
      monitor = [",preferred,auto,1"];
      general = {
        layout = "dwindle";
        border_size = 0;
        gaps_in = 6;
        gaps_out = 12;
        allow_tearing = false;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = "yes";
        };
      };
      dwindle = {
        pseudotile = true;
        force_split = 0;
        preserve_split = true;
        smart_split = true;
        smart_resizing = true;
      };
      gestures = {
        workspace_swipe = "on";
        workspace_swipe_fingers = 3;
        workspace_swipe_create_new = true;
      };
      decoration = {
        rounding = 0;
      };
    };
    extraConfig = ''
      env = XCURSOR_SIZE,24
      env = WLR_RENDERER_ALLOW_SOFTWARE,1

      $term = foot
      $mainMod = Super

      bind = CtrlAlt, T, exec, $term
    '';
  };
}
