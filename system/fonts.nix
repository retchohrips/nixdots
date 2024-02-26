{
  userSettings,
  pkgs,
  ...
}: {
  fonts = {
    fontconfig = {
      enable = true;

      antialias = true; # Fix pixelation
      cache32Bit = true;

      hinting = {
        # Fix antialiasing blur
        enable = true;
        autohint = false;
        style = "slight";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };

    fontDir = {
      # Needed for flatpaks
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      corefonts
      vistafonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      cozette
      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "CommitMono"
          "CascadiaCode"
          "VictorMono"
          "ProggyClean"
          "NerdFontsSymbolsOnly"
        ];
      })
    ];
  };
}
