{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.packages = [pkgs.gcr]; # GNOME services outside of GNOME
    udev.packages = [pkgs.gnome.gnome-settings-daemon];

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            /*
            bash
            */
            ''
              ${pkgs.greetd.tuigreet}/bin/tuigreet \
                      --time --user-menu --remember --remember-user-session \
                      --cmd Hyprland
            '';
          user = "greeter";
        };
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    ANKI_WAYLAND = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "true";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Secret" = [
        "gnome-keyring"
      ];
    };
  };
}
