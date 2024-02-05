{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    # style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = ["clock"];
      };
    };
  };
}
