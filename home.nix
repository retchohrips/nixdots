{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-colors.homeManagerModules.default
    ./programs/starship.nix
    ./programs/nixvim
    # ./programs/firefox.nix # Using Brave
    ./programs/beets.nix
    ./dewm/${userSettings.dewm}.nix
    ./fonts.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home = {
    # Do not change the below value. It determines the Home Manager release
    # that this config is compatible with. Do not change it,
    # even when Home Manager updates.
    stateVersion = "23.11";

    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

    sessionVariables = {EDITOR = "nvim";};

    packages =
      (with pkgs; [
        brave
        obsidian
        vscode.fhs
        telegram-desktop
        # vesktop # Kinda sucks on nixos...
        lutris

        # CLI tools
        lazygit
        tldr
        alejandra # Needed for pre-commit hooks

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ])
      ++ (with inputs.nix-gaming.packages.${pkgs.system}; [wine-ge]);

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
      ls = "eza --icons --no-quotes --group-directories-first";
      ll = "eza --long --git --icons --header --total-size --time-style relative --smart-group";
      la = "eza --icons --no-quotes --group-directories-first -a";
      lla = "eza --long --git --icons --header --total-size --time-style relative --smart-group -a";
      rg = "rg --smart-case";
    };
  };

  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        g = "git";
        ga = "git add";
        gaa = "git add --all";
        gb = "git branch --verbose";
        gc = "git commit -m";
        gca = "git commit --amend";
        gcl = "git clone";
        gs = "git status";
        gss = "git status --short";
        gd = "git diff";
        gds = "git diff --staged";
        gf = "git fetch";
        gi = "git init";
        gl = "git log --oneline --decorate --graph -n 10";
        gm = "git merge";
        gp = "git push";
        gpu = "git pull";
        nf = "nix flake";
        nfu = "nix flake update";
        npr = "nixpkgs-review pr --run fish --print-result";
        nd = "nix develop --command fish";
        nb = "nix build";
        ns = "nix shell";
        nr = "nix run";
        ncg = "sudo nix-collect-garbage -d";
        nrb = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake ~/.dotfiles && nix-store --optimise";
        # nvd = "nvd --color always diff /run/current-system result | less -R";
        c = "clear";
        e = "exit";
        v = "nvim";
      };
      interactiveShellInit =
        /*
        fish
        */
        ''
          set fish_greeting # Disable greeting
          set sponge_purge_only_on_exit true
        '';
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    };

    bat = {
      enable = true;
      config = {theme = "ansi";};
    };

    git = {
      enable = true;
      userEmail = "44993244+retchohrips@users.noreply.github.com";
      userName = "retchohrips";
      extraConfig = {init = {defaultBranch = "main";};};

      delta.enable = true;
    };

    gh.enable = true;

    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      shellIntegration.enableFishIntegration = true;
      settings = {
        font = "${userSettings.font}";
        cursor_shape = "beam";
        window_padding_width = 5;
        confirm_os_window_close = 0;
        linux_display_server = "x11";
        background_opacity = "0.50";
        enabled_layouts = "tall, grid, splits";
      };
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
