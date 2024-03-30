{
  pkgs,
  userSettings,
  config,
  inputs,
  ...
}: let
  theme = "${pkgs.base16-schemes}/share/themes/${userSettings.theme}.yaml";
  inputImage = ../../wallpapers/${userSettings.pape};

  genWallpaper = pkgs.runCommand "image.png" {} ''
    tmp="$(mktemp -d)"
        ${pkgs.lutgen}/bin/lutgen apply -o $tmp ${inputImage} -- ${config.lib.stylix.colors.base00} ${config.lib.stylix.colors.base01} ${config.lib.stylix.colors.base02} ${config.lib.stylix.colors.base03} ${config.lib.stylix.colors.base04} ${config.lib.stylix.colors.base05} ${config.lib.stylix.colors.base06} ${config.lib.stylix.colors.base07} ${config.lib.stylix.colors.base08} ${config.lib.stylix.colors.base09} ${config.lib.stylix.colors.base0A} ${config.lib.stylix.colors.base0B} ${config.lib.stylix.colors.base0C} ${config.lib.stylix.colors.base0D} ${config.lib.stylix.colors.base0E} ${config.lib.stylix.colors.base0F}
      ${pkgs.imagemagick}/bin/convert $tmp/* $tmp/wallpaper.png
      mv $tmp/wallpaper.png $out
  '';
in {
  imports = [inputs.stylix.homeManagerModules.stylix];
  stylix = {
    image =
      if (userSettings.genPape == "yes")
      then genWallpaper
      else ../../wallpapers/${userSettings.pape};
    base16Scheme = theme;

    cursor = {
      name = "Catppuccin-Frappe-Dark-Cursors";
      size = 24;
      package = pkgs.catppuccin-cursors.frappeDark;
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
      flavor = "frappe";
    };
  };
}
