{
  pkgs,
  userSettings,
  ...
}: {
  imports = [./waybar ./rofi];

  home.packages = with pkgs; [
    swww
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    # iconTheme.package = pkgs.morewaita-icon-theme;
    # iconTheme.name = "MoreWaita";
    theme = {
      package = pkgs.catppuccin-gtk.override {
        size = "standard";
        accents = ["blue"];
        variant = "mocha";
        tweaks = ["normal"];
      };
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprctl setcursor Catppuccin-Mocha-Dark-Cursors 24"
        "waybar"
        "swww init"
        "sleep 10 ; swww img ~/.wallpapers/${userSettings.pape}"
      ];
      monitor = [",preferred,auto,1"];
      general = {
        layout = "dwindle";
        border_size = 0;
        gaps_in = 5;
        gaps_out = 10;
        allow_tearing = false;
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
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
        accel_profile = "flat";
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
        drop_shadow = true;
        shadow_range = 40;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000088)";
        "col.shadow_inactive" = "rgba(00000070)";
        dim_inactive = true;
        dim_strength = 0.1;
        dim_special = 0;
        blur = {
          enabled = true;
          special = true;
          popups = true;
          ignore_opacity = false;
          xray = false;
          size = 10;
          passes = 3;
          contrast = 1.2;
          brightness = 1;
          vibrancy = 1;
          noise = 0.02;
        };
      };
      windowrule = ["float, ^Rofi"];
      layerrule = [
        "blur, waybar$"
        "ignorezero, rofi$"
        "blur, rofi$"
        "blur, notifications$"
        "ignorezero, notifications$"
      ];
      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        arr = [1 2 3 4 5 6 7 8 9];
        term = "kitty";
        inherit (userSettings) browser;
      in
        [
          "CtrlAlt, T, exec, ${term}"
          "SUPER, B, exec, ${browser}"
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

      bindr = ["SUPER, SUPER_L, exec, rofi -show drun || pkill rofi"];
    };

    extraConfig = ''
      env = XCURSOR_SIZE,24
      env = WLR_RENDERER_ALLOW_SOFTWARE,1
    '';
  };
}
