{pkgs, ...}: {
  home.shellAliases = {
    ls = "eza --icons --no-quotes --group-directories-first";
    ll = "eza --long --git --icons --header --total-size --time-style relative --smart-group";
    la = "eza --icons --no-quotes --group-directories-first -a";
    lla = "eza --long --git --icons --header --total-size --time-style relative --smart-group -a";
    rg = "rg --smart-case";
    fd = "fd -Lu";
    fetch = "disfetch";
    gitfetch = "onefetch";
    rcp = "rsync --compress --verbose --human-readable --partial --progress";
  };

  programs.fish = {
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
      gd = "git difftool --no-symlinks --dir-diff";
      gds = "git difftool --no-symlinks --dir-diff --staged";
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
      c = "clear";
      e = "exit";
      v = "nvim";
      cd = "z";
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

  home.packages = with pkgs; [
    pre-commit
    commitizen
    lazygit
    tldr
    alejandra # Needed for pre-commit hooks

    eza
    unzip
    p7zip
    ripgrep

    fishPlugins.puffer
    fishPlugins.bass
    fishPlugins.sponge
    fishPlugins.pisces
    fishPlugins.colored-man-pages

    # Package management
    nodejs
    cargo
    nodePackages.pnpm

    disfetch
    lolcat
    cowsay
    onefetch
    fd
    fzf
    libnotify
  ];

  # xdg.configFile."btop/themes".source = "${inputs.catppuccin-btop}/themes";

  programs = {
    btop = {
      enable = true;
      settings = {
        # color_theme = "catppuccin_mocha";
        theme_background = false; # Makes btop transparent
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
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
        init = {defaultBranch = "main";};
      };
    };

    gh.enable = true;
  };
}
