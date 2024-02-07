{
  pkgs,
  inputs,
  ...
}: let
  moreWaita = pkgs.stdenv.mkDerivation {
    name = "MoreWaita";
    src = inputs.more-waita;
    installPhase = ''
      mkdir -p $out/share/icons
      mv * $out/share/icons
    '';
  };
in {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      "org/gnome/desktop/interface".clock-format = "12h";
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "kitty";
        name = "open-terminal";
      };
      "org/gnome/desktop/wm/keybindings".close = "<Super>c";
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "forge@jmmaranan.com"
          "gsconnect@andyholmes.github.io"
          "trayIconsReloaded@selfmade.pl"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
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
    iconTheme.name = moreWaita.name;
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

  home.packages = with pkgs; [
    moreWaita
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.gsconnect
    gnomeExtensions.forge
  ];
}
