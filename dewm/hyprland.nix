{
  pkgs,
  config,
  lib,
  userSettings,
  inputs,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  imports = [
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    ./waybar
    ./rofi
    ./dunst.nix
    ../programs/ranger
    ../programs/ncmpcpp.nix
    ../programs/mpd.nix
  ];

  home.packages = with pkgs; [
    feh
    wl-clipboard
    cliphist
    gnome.nautilus
    grimblast
    grim
    slurp
    brightnessctl
    hyprpaper
    tesseract4

    (pkgs.writeScriptBin "screenshot-ocr"
      /*
      bash
      */
      ''
        imgname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S).png"
        txtname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S)"
        txtfname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S).txt"
        grim -g "$(slurp)" $imgname;
        tesseract $imgname $txtname;
        wl-copy -n < $txtfname
      '')
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = $HOME/.local/share/backgrounds/${userSettings.pape}
    wallpaper = ,$HOME/.local/share/backgrounds/${userSettings.pape}
    splash = false
  '';

  services.hypridle = {
    enable = true;
    lockCmd = "hyprlock";
    ignoreDbusInhibit = false;
    beforeSleepCmd = "hyprlock";

    listeners = [
      {
        timeout = 3 * 60;
        onTimeout = "hyprlock";
      }
      {
        timeout = (3 * 60) + 30;
        onTimeout = "${pkgs.coreutils}/bin/sleep 1 && hyprctl dispatch dpms off";
        onResume = "hyprctl dispatch dpms on";
      }
    ];
  };

  programs.hyprlock = {
    enable = true;
    general = {
      disable_loading_bar = false;
      hide_cursor = true;
    };

    backgrounds = [
      {
        path = "screenshot";
        blur_passes = 4;
        blur_size = 4;
        contrast = 1.2;
        brightness = 1.0;
        vibrancy = 1.0;
        noise = 2.0e-2;
      }
    ];

    input-fields = [
      {
        size.width = 300;
        size.height = 40;
        outline_thickness = 3;
        dots_center = true;
        outer_color = "0xff${palette.base00}";
        inner_color = "0xff${palette.base05}";
        font_color = "0xff${palette.base00}";
        fade_on_empty = false;
        dots_spacing = 0.3;
        placeholder_text = "";
        hide_input = false;
        position = {
          x = 0;
          y = -50;
        };
        halign = "center";
        valign = "center";
      }
    ];

    labels = [
      {
        text = ''cmd[update:100] echo "<b>$(date +'%_I:%M:%S')</b>"'';
        position = {
          x = 0;
          y = 30;
        };
        font_family = "${userSettings.font}";
        font_size = 40;
        color = "0xff${palette.base07}";
      }
    ];
  };

  services.udiskie = {
    enable = true;
    automount = true;
    tray = "auto";
  };

  systemd.user.services.swayidle.Install.WantedBy =
    lib.mkForce ["hyprland-session.target"];

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
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
        "telegram-desktop -startintray"
        "waybar"
        "dunst"
        "hyprpaper"
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
        numlock_by_default = true;
        touchpad = {natural_scroll = "yes";};
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
        shadow_range = 10;
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
      };
      windowrule = ["float, ^Rofi" "tile, ^(kitty)$"];
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
          "SUPER, RETURN, exec, ${term}"
          "SUPER, B, exec, ${browser}"
          "ALT, Tab, focuscurrentorlast"
          "CTRL ALT, Delete, exit"
          "SUPER, C, killactive"
          "SUPER, F, togglefloating"
          "SUPER, G, fullscreen"
          "SUPER, O, fakefullscreen"
          "SUPER, P, togglesplit"
          "SUPER SHIFT, X, exec, $HOME/.config/rofi/powermenuhack/powermenu.sh"
          "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          "SUPER, L, exec, hyprlock"
          "SUPER, T, exec, telegram-desktop"
          "SUPER, E, exec, nautilus"
          "SUPER, S, exec, grimblast copy area"
          "SUPERSHIFT, T, exec, screenshot-ocr"

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

      bindm = ["SUPER, mouse:273, resizewindow" "SUPER, mouse:272, movewindow"];

      bindr = ["SUPER, SUPER_L, exec, rofi -show drun || pkill rofi"];

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

    extraConfig = ''
      env = XCURSOR_SIZE,24
      env = WLR_RENDERER_ALLOW_SOFTWARE,1
    '';
  };
}
