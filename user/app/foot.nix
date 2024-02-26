{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        box-drawings-uses-font-glyphs = false;
        pad = "2x2 center";
        bold-text-in-bright = false;
      };
    };
  };
}
