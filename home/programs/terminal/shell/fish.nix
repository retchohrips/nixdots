{
  pkgs,
  config,
  ...
}: {
  stylix.targets.fish.enable = !config.programs.kitty.enable;
  programs.fish = {
    enable = true;
    shellAliases = {
      rg = "rg --smart-case";
      fd = "fd -Lu";
      rcp = "rsync --compress --human-readable --partial --info=progress2";
    };
    shellAbbrs = {
      g = "git";
      gaa = "git add --all";
      gc = "git commit -m";
      gca = "git commit --amend";
      gcl = "git clone";
      gf = "git fetch";
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

        set fish_color_autosuggestion brwhite
        set fish_color_command brcyan
        set fish_color_comment yellow
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_end magenta
        set fish_color_error red
        set fish_color_escape cyan
        set fish_color_history_current --bold
        set fish_color_host normal
        set fish_color_host_remote yellow
        set fish_color_match brblue
        set fish_color_normal normal
        set fish_color_operator brblue
        set fish_color_param white
        set fish_color_quote yellow
        set fish_color_redirection brwhite
        set fish_color_search_match 'bryellow'  '--background=brblack'
        set fish_color_selection 'white'  '--bold'  '--background=brblack'
        set fish_color_status red
        set fish_color_user brgreen
      '';
  };

  home.packages = with pkgs; [
    fishPlugins.puffer
    fishPlugins.bass
    fishPlugins.sponge
    fishPlugins.pisces
    fishPlugins.colored-man-pages
    fishPlugins.forgit
  ];
}
