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
    fishPlugins.puffer
    fishPlugins.bass
    fishPlugins.sponge
    fishPlugins.pisces
    fishPlugins.colored-man-pages
    fishPlugins.forgit
  ];
}
