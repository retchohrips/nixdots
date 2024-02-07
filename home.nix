{
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    # ./dewm/hyprland.nix
    ./programs/starship.nix
    ./programs/nvim.nix
    ./programs/firefox.nix
    ./dewm/gnome.nix
    # ./stylix.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = userSettings.username;
  # home.homeDirectory = "/home/" + userSettings.username;

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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})

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

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    userEmail = "44993244+retchohrips@users.noreply.github.com";
    userName = "retchohrips";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.git.delta.enable = true;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
