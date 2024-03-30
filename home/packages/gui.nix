{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    vscode.fhs
    telegram-desktop
    blender
    krita
    inkscape
    vlc
    foliate
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
