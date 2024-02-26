{
  userSettings,
  config,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # font = "${userSettings.font}:size=12,SymbolsNerdFont:size=12";
        box-drawings-uses-font-glyphs = false;
        pad = "2x2 center";
        bold-text-in-bright = false;
      };
      # colors = {
      #   foreground = palette.base05;
      #   background = palette.base00;
      #   regular0 = palette.base00;
      #   regular1 = palette.base08;
      #   regular2 = palette.base0B;
      #   regular3 = palette.base0A;
      #   regular4 = palette.base0D;
      #   regular5 = palette.base0E;
      #   regular6 = palette.base0C;
      #   regular7 = palette.base05;
      #   bright0 = palette.base03;
      #   bright1 = palette.base08;
      #   bright2 = palette.base0B;
      #   bright3 = palette.base0A;
      #   bright4 = palette.base0D;
      #   bright5 = palette.base0E;
      #   bright6 = palette.base0C;
      #   bright7 = palette.base07;
      # };
    };
  };
}
