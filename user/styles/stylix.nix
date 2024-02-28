{
  pkgs,
  userSettings,
  ...
}: {
  stylix = {
    image = ../../wallpapers/${userSettings.pape};
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${userSettings.theme}.yaml";

    cursor = {
      size = 24;
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark-Cursors";
    };

    fonts = {
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
  };
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.catppuccin-papirus-folders.override {
      accent = "blue";
      flavor = "mocha";
    };
  };
}
