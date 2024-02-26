{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix

    ./user/shell/sh.nix
    ./user/shell/starship.nix
    ./user/shell/tmux.nix

    ./user/styles/stylix.nix

    ./user/dewm/${userSettings.dewm}

    ./user/app/${userSettings.browser}
    ./user/app/beets.nix
    ./user/app/foot.nix
    ./user/app/neovim.nix

    ./user/gaming.nix
  ];

  home = {
    # Do not change the below value. It determines the Home Manager release
    # that this config is compatible with. Do not change it,
    # even when Home Manager updates.
    stateVersion = "23.11";

    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

    packages = with pkgs; [
      obsidian
      vscode.fhs
      telegram-desktop
      # vesktop # Kinda sucks on nixos...
      # blender # broken rn???
      gimp-with-plugins
      krita
      vlc
    ];

    file = {
      ".local/share/backgrounds" = {
        source = ./wallpapers;
        recursive = true;
      };
    };
  };

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

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

    steam = {
      name = "Steam";
      genericName = "Game launcher";
      exec = "flatpak run com.valvesoftware.Steam";
      # categories = ["Games"];
      icon = "steam";
      terminal = false;
    };
  };
}
