{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swww
    waybar
  ];

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   package = pkgs.catppuccin-cursors.mochaDark;
  #   name = "Catppuccin-Mocha-Dark-Cursors";
  #   size = 24;
  # };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.catppuccin-gtk.override {
  #       size = "standard";
  #       accents = ["blue"];
  #       variant = "mocha";
  #       tweaks = ["normal"];
  #     };
  #     name = "Catppuccin-Mocha-Standard-Blue-Dark";
  #   };
  # };

  home.file = {
    ".wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprctl setcursor Catppuccin-Mocha-Dark-Cursors 24"
        "waybar"
        "swww init"
        "swww img ~/.wallpapers/Makima_Persona.png"
      ];
      monitor = [",preferred,auto,1"];
      general = {
        layout = "dwindle";
        border_size = 0;
        gaps_in = 6;
        gaps_out = 12;
        allow_tearing = false;
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
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
        rounding = 5;
      };
      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        arr = [1 2 3 4 5 6 7 8 9];
        term = "kitty";
      in
        [
          "CtrlAlt, T, exec, ${term}"
          "SUPER, B, exec, firefox"
          "ALT, Tab, focuscurrentorlast"
          "CTRL ALT, Delete, exit"
          "SUPER, C, killactive"
          "SUPER, F, togglefloating"
          "SUPER, G, fullscreen"
          "SUPER, O, fakefullscreen"
          "SUPER, P, togglesplit"

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
          (mvactive "k" "0 -20")
          (mvactive "j" "0 20")
          (mvactive "l" "20 0")
          (mvactive "h" "-20 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];
    };

    extraConfig = ''
      env = XCURSOR_SIZE,24
      env = WLR_RENDERER_ALLOW_SOFTWARE,1
    '';
  };
}
