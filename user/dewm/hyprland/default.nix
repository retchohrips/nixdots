{
  pkgs,
  userSettings,
  config,
  ...
}: {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./waybar
    ./rofi
    ./dunst.nix
    ./mimelist.nix
    ../../app/ranger
    ../../app/ncmpcpp.nix
    ../../app/mpd.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    loupe
    gnome.nautilus
    gnome.sushi # File previewer for Nautilus
    gnome.seahorse
    gnome.totem
    gnome-text-editor
    gnome.gnome-calculator
    xarchiver
    zathura
    grimblast
    grim
    slurp
    brightnessctl
    hyprpaper
    wlsunset
    jq
    tesseract4
    gnupg
    hyprpicker

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

    (pkgs.writeScriptBin "wlsunset-auto"
      /*
      bash
      */
      ''
        curl https://ipinfo.io/json | jq -r '.loc' | awk -F, '{print "-l " $1 " -L " $2}' | xargs wlsunset
      '')
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.stylix.image}
    wallpaper = ,${config.stylix.image}
    splash = false
  '';

  xdg.mimeApps.defaultApplications."inode/directory" = "nautilus.desktop";

  services.udiskie = {
    enable = true;
    tray = "auto";
  };

  qt.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "Polkit GNOME Authentication Agent";
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      Slice = "session.slice";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      exec-once = [
        "hyprctl setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
        "gnome-keyring-daemon --start --components=secrets"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "telegram-desktop -startintray"
        "waybar"
        "dunst"
        "hyprpaper"
        "wlsunset-auto"
      ];
      monitor = [",highres,auto,auto"];
      general = {
        layout = "dwindle";
        border_size = 2;
        gaps_in = 3;
        gaps_out = 6;
        allow_tearing = false;
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        animate_manual_resizes = true;
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
        dim_inactive = false;
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
      windowrule = [
        "float, ^Rofi"
        "tile, ^(kitty)$"
      ];
      windowrulev2 = [
        "float, class:(firefox), title:^(Extension: \(Bitwarden - Free Password Manager\))"
        "float, class:^(org.telegram.desktop|telegramdesktop)$, title:^(Media viewer)$"
      ];
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
          "CTRL ALT, Delete, exec, $HOME/.config/rofi/powermenuhack/powermenu.sh"
          "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
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
          (mvactive "k" "u")
          (mvactive "j" "d")
          (mvactive "l" "r")
          (mvactive "h" "l")
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

      env = [
        "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
      ];
    };
  };
}
