{ pkgs, astronvim, lib, ... }:

{

  imports = [ ./hyprland.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bunny";
  home.homeDirectory = "/home/bunny";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bunny/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    set fish_greeting # Disable greeting
  '';

  programs.starship.enable = true;
  programs.starship.enableTransience = true;
  programs.starship.settings = {
    format = lib.concatStrings [
      "$username"
    ];
    character = {
      succes_symbol = "xx";
    };
  };

  programs.neovim =
  {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      gcc # It gets mad if it can't compile C...
      unzip
      wget
      curl
      tree-sitter
      ripgrep
      lazygit
    ];
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono NF:size=10";
        underline-offset = 1;
        underline-thickness = 1;
        box-drawings-uses-font-glyphs = "yes";
        pad = "12x12 center";
        bold-text-in-bright = "no";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
      colors = {
        foreground = "cdd6f4";
        background = "1e1e2e";
        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";
        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";
      };
    };
  };

  xdg.configFile = {
    astronvim = {
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
      source = ./astronvim;
    };

    nvim = {
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
      source = astronvim;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
