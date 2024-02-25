{
  inputs,
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  stylix.image = ../../wallpapers/${userSettings.pape};
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.targets.rofi.enable = false;
  stylix.targets.waybar.enable = false;
  stylix.targets.fish.enable = false; # Fish can just use terminal colors

  stylix.cursor = {
    size = 24;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
  };

  stylix.fonts = {
    monospace = {
      name = "${userSettings.font} Nerd Font";
      package = with pkgs; (nerdfonts.override {fonts = ["${userSettings.font}"];});
    };
    sansSerif = {
      name = "Inter";
      package = pkgs.inter;
    };
    serif = {
      name = "Noto Serif";
      package = pkgs.noto-fonts;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
  };

  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.catppuccin-papirus-folders.override {
      accent = "blue";
      flavor = "mocha";
    };
  };
}
