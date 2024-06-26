{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  config = lib.mkIf (builtins.elem osConfig.modules.device.type acceptedTypes) {
    home.packages = with pkgs; [
      obsidian # notes program
      vscode.fhs # code editor
      telegram-desktop # messenger
      blender # 3d modelling
      krita # drawing program
      gimp-with-plugins # raster image editor
      inkscape # vector editor
      vlc # video player
      foliate # ebook viewer
      zathura # pdf viewer
      # calibre # ebook manager # broken rn
    ];

    xdg.desktopEntries = {
      # Obsidian won't run on Wayland without this
      obsidian = {
        name = "Obsidian";
        genericName = "Knowledge base";
        exec = "env WAYLAND_DISPLAY= obsidian %u";
        categories = ["Application" "Office"];
        icon = "obsidian";
        terminal = false;
        mimeType = ["x-scheme-handler/obsidian"];
      };
    };
  };
}
