{
  userSettings,
  pkgs,
  ...
}: {
  fonts = {
    fontconfig = {
      enable = true;

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["${userSettings.font}" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Inter" "Noto Color Emoji"];
      };

      antialias = true; # Fix pixelation
      hinting = {
        # Fix antialiasing blur
        enable = true;
        autohint = true;
        style = "full";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };

    fontDir = {
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
          "ProggyClean"
          "NerdFontsSymbolsOnly"
        ];
      })
    ];
  };
}
