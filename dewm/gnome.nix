{
  pkgs,
  inputs,
  ...
}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      "org/gnome/desktop/peripherals/keyboard".remember-numlock-state = true;
      "org/gnome/desktop/interface".clock-format = "12h";
      "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        www = ["<Super>b"];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "kitty";
        name = "Open Kitty";
      };
      "org/gnome/desktop/wm/keybindings" = {close = ["<Super>c"];};
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          # "forge@jmmaranan.com"
          "gsconnect@andyholmes.github.io"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "dash-to-dock@micxgx.gmail.com"
        ];
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        custom-theme-shrink = true;
        intellihide-mode = "ALL_WINDOWS";
        require-pressure-to-show = false;
        show-mounts = false;
        show-show-apps-button = false;
        show-trash = false;
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    iconTheme.package = pkgs.morewaita-icon-theme;
    iconTheme.name = "MoreWaita";
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

  home.packages =
    (with pkgs.gnomeExtensions; [
      gsconnect
      dash-to-dock
      # forge
    ])
    ++ (with pkgs; [
      ]);
}
