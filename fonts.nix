{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    corefonts
    vistafonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    # cozette
    (google-fonts.override {fonts = ["Inter"];})
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        # "CommitMono"
        "CascadiaCode"
        "ProggyClean"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];
}
