{
  pkgs,
  config,
  lib,
  ...
}: let
  acceptedTypes = ["laptop" "desktop"];
in {
  fonts = lib.mkIf (builtins.elem config.modules.device.type acceptedTypes) {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      corefonts # Microsoft fonts
      vistafonts # more MS fonts!
      b612
      noto-fonts
      noto-fonts-cjk
      cozette
      inter
      lato
      lexend
      work-sans
      comic-neue
      source-sans
      (google-fonts.override {
        fonts = [
          "Indie Flower"
          "Playpen Sans"
          "Redacted Script"
          "Pangolin"
          "Ubuntu"
          "Ubuntu Mono"
        ];
      })
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "CommitMono"
          "CascadiaCode"
          "FantasqueSansMono"
          "VictorMono"
          "ProggyClean"
          "NerdFontsSymbolsOnly"
        ];
      })
      material-icons
      material-design-icons

      # emojis
      twemoji-color-font
      openmoji-color
      openmoji-black
      noto-fonts-emoji
      noto-fonts-color-emoji
    ];
  };
}
