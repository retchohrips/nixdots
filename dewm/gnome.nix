{
  pkgs,
  userSettings,
  ...
}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      "org/gnome/desktop/peripherals/keyboard".remember-numlock-state = true;
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        font-name = "Inter 11";
        document-font-name = "Inter 11";
        monospace-font-name = "CommitMono 10";
        titlebar-font = "Inter Bold 11";
        font-antialiasing = "rgba";
      };
      "org/gnome/mutter".center-new-windows = true;
      "org/gnome/desktop/wm/preferences".resize-with-right-button = true;
      "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";
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
          # "gsconnect@andyholmes.github.io"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "dash-to-dock@micxgx.gmail.com"
          "AlphabeticalAppGrid@stuarthayhurst"
          "Vitals@CoreCoding.com"
        ];
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/${userSettings.username}/.local/share/backgrounds/Makima_Persona.png";
        picture-uri-dark = "file:///home/${userSettings.username}/.local/share/backgrounds/Makima_Persona.png";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///home/${userSettings.username}/.local/share/backgrounds/Makima_Persona.png";
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
      # gsconnect
      dash-to-dock
      vitals
      alphabetical-app-grid
      # forge
    ])
    ++ (with pkgs; [
      evolution
    ]);
}
