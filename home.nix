{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  imports = [
    inputs.neovim-flake.homeManagerModules.default
    ./programs/starship.nix
    ./programs/neovim.nix
    # ./programs/firefox.nix
    ./programs/beets.nix
    ./programs/ranger
    ./dewm/${userSettings.dewm}.nix
    ./fonts.nix
  ];

  home = {
    # Do not change the below value. It determines the Home Manager release
    # that this config is compatible with. Do not change it,
    # even when Home Manager updates.
    stateVersion = "23.11";
    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

    packages =
      (with pkgs; [
        # inputs.Neve.packages.${system}.default
        brave
        obsidian
        vscode.fhs
        telegram-desktop
        vesktop
        lutris

        # CLI tools
        lazygit

        # AstroNvim
        gcc # astronvim gets mad if it can't compile C...
        nil # nix LS
        alejandra # nix formatter
        statix # lints and suggestions
        deadnix # clean up unused nix code
        tree-sitter

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ])
      ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
        wine-ge
      ]);

    file = {
      ".local/share/backgrounds" = {
        source = ./wallpapers;
        recursive = true;
      };

      # Obsidian won't run on Wayland
      ".local/share/applications/obsidian.desktop" = {
        text = ''
          [Desktop Entry]
          Categories=Office
          Comment=Knowledge base
          Exec=env WAYLAND_DISPLAY= obsidian %u
          Icon=obsidian
          MimeType=x-scheme-handler/obsidian
          Name=Obsidian
          Type=Application
          Version=1.4'';
      };
    };

    shellAliases = {
      ls = "eza --icons";
    };
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    bat = {
      enable = true;
      config = {theme = "ansi";};
    };

    git = {
      enable = true;
      userEmail = "44993244+retchohrips@users.noreply.github.com";
      userName = "retchohrips";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };

      delta.enable = true;
    };

    gh.enable = true;

    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      settings = {
        font = "CommitMono";
        cursor_shape = "beam";
        window_padding_width = 5;
        confirm_os_window_close = 0;
        linux_display_server = "x11";
        background_opacity = "0.85";
      };
    };

    tealdeer = {
      enable = true;
      settings = {updates = {auto_update = true;};};
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
