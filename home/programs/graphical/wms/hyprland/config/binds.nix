{
  userSettings,
  pkgs,
  ...
}: let
  ocr =
    pkgs.writeShellScript "ocr"
    ''
      ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.tesseract}/bin/tesseract -l eng - - | ${pkgs.wl-clipboard}/bin/wl-copy
    '';
in {
  wayland.windowManager.hyprland.settings = {
    bind = let
      binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
      mvfocus = binding "SUPER" "movefocus";
      ws = binding "SUPER" "workspace";
      resizeactive = binding "SUPER CTRL" "resizeactive";
      mvactive = binding "SUPER ALT" "moveactive";
      mvtows = binding "SUPER SHIFT" "movetoworkspace";
      arr = [1 2 3 4 5 6 7 8 9];
      inherit (userSettings) browser terminal;
    in
      [
        "SUPER, RETURN, exec, ${terminal}"
        "SUPER, B, exec, ${browser}"
        "SUPER, Period, exec, rofi -modi emoji -show emoji"
        "ALT, Tab, focuscurrentorlast"
        "SUPER, C, killactive"
        "SUPER, F, togglefloating"
        "SUPER, G, fullscreen"
        "SUPER, O, fakefullscreen"
        "SUPER, P, togglesplit"
        "CTRL ALT, Delete, exec, wlogout -p layer-shell"
        "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "SUPER, T, exec, telegram-desktop"
        "SUPER, E, exec, nautilus"
        "SUPER, S, exec, grimblast copy area"
        "SUPERSHIFT, T, exec, ${ocr}"
        "SUPERSHIFT, N, exec, swaync-client -t -sw"

        (mvfocus "k" "u")
        (mvfocus "j" "d")
        (mvfocus "l" "r")
        (mvfocus "h" "l")
        (ws "left" "e-1")
        (ws "right" "e+1")
        (mvtows "left" "e-1")
        (mvtows "right" "e+1")
        (resizeactive "k" "0 -20")
        (resizeactive "j" "0 20")
        (resizeactive "l" "20 0")
        (resizeactive "h" "-20 0")
        (mvactive "k" "u")
        (mvactive "j" "d")
        (mvactive "l" "r")
        (mvactive "h" "l")
      ]
      ++ (map (i: ws (toString i) (toString i)) arr)
      ++ (map (i: mvtows (toString i) (toString i)) arr);

    bindm = ["SUPER, mouse:273, resizewindow" "SUPER, mouse:272, movewindow"];

    bindr = ["SUPER, SUPER_L, exec, pkill anyrun || anyrun"];

    bindle = [
      # Volume
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      "SUPER, F1, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      "SUPER, F2, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      "SUPER, F3, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      # Media Control
      ",XF86AudioPrev, exec, mpc prev"
      ",XF86AudioPlay, exec, mpc toggle"
      ",XF86AudioNext, exec, mpc next"
      "SUPER, F5, exec, mpc prev"
      "SUPER, F6, exec, mpc toggle"
      "SUPER, F7, exec, mpc next"
      # Brightness
      ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];
  };
}
