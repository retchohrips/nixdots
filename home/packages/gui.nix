{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian # notes program
    vscode.fhs # code editor
    telegram-desktop # messenger
    blender # 3d modelling
    krita # drawing program
    inkscape # vector editor
    vlc # video player
    foliate # ebook viewer
    zathura # pdf viewer
    calibre # ebook manager
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
}
