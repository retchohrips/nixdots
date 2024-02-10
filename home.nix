{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  imports = [
    # ./dewm/hyprland.nix
    ./programs/starship.nix
    ./programs/nvim.nix
    # ./programs/nixvim
    ./programs/firefox.nix
    ./programs/beets.nix
    ./dewm/gnome.nix
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages =
    (with pkgs; [
      # inputs.Neve.packages.${system}.default
      obsidian
      vscode.fhs
      telegram-desktop
      vesktop
      lutris
      cartridges
      (nerdfonts.override {fonts = ["JetBrainsMono"];}) # Installs ONLY JetBrainsMono

      # CLI tools
      lazygit

      # Fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      inter

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

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.file = {
    ".local/share/backgrounds" = {
      source = ./wallpapers;
      recursive = true;
    };

    # Obsidian won't run on wayland
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

  home.shellAliases = {
    ls = "eza --icons";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.bat = {
    enable = true;
    config = {theme = "ansi";};
  };

  programs.git = {
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

  programs.gh.enable = true;

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font = "JetBrainsMono NF";
      cursor_shape = "beam";
      window_padding_width = 5;
      confirm_os_window_close = 0;
      linux_display_server = "x11";
    };
  };

  programs.tealdeer = {
    enable = true;
    settings = {updates = {auto_update = true;};};
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
