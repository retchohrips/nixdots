{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./user/shell/sh.nix
    ./user/shell/starship.nix

    ./user/dewm/${userSettings.dewm}

    ./user/app/${userSettings.browser}
    ./user/app/beets.nix
    ./user/app/kitty.nix
    ./user/app/neovim.nix

    ./user/gaming.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

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
      blender
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
  };
}
