{
  lib,
  pkgs,
  config,
  ...
}: {
  nix = {
    settings = {
      # only allow sudo users to manage the nix store
      trusted-users = ["root" "@wheel"];
      # Caches to pull from so we don't have to build packages
      substituters =
        [
          "https://cache.nixos.org"
          "https://nixpkgs-wayland.cachix.org" # automated builds of *some* wayland packages
          "https://nix-community.cachix.org"
          "https://nixpkgs-unfree.cachix.org" # unfree-package cache
          "https://numtide.cachix.org" # another unfree package cache
          "https://nix-gaming.cachix.org"
          "https://anyrun.cachix.org"
        ]
        ++ lib.optionals
        config.programs.hyprland.enable [
          "https://hyprland.cachix.org"
        ];
      trusted-public-keys =
        [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        ]
        ++ lib.optionals config.programs.hyprland.enable ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

      experimental-features = ["nix-command" "flakes"];

      # let the system decide the number of max jobs
      max-jobs = "auto";

      # Free up to 10GiB whenever there is less than 5GB left.
      # this setting is in bytes, so we multiply with 1024 thrice
      min-free = "${toString (5 * 1024 * 1024 * 1024)}";
      max-free = "${toString (10 * 1024 * 1024 * 1024)}";

      # automatically optimise symlinks
      auto-optimise-store = true;

      # don't warn me that my git tree is dirty, I know
      warn-dirty = false;

      # use binary cache, this is not gentoo
      # external builders can also pick up those substituters
      builders-use-substitutes = true;
    };

    # Garbage collection, remove packages that are older than 7d
    # Disabled, using nh instead
    # gc = {
    #   automatic = true;
    #   dates = "Mon *-*-* 03:00";
    #   options = "--delete-older-than 7d";
    # };

    # automatically optimize nix store my removing hard links
    # (after the gc)
    optimise = {
      automatic = true;
      dates = ["04:00"];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"]; # Allows Obsidian to be installed

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";

  system.autoUpgrade.enable = false;

  # git is required for flakes
  environment.systemPackages = with pkgs; [git];

  # faster rebuilding
  documentation = {
    doc.enable = false;
    nixos.enable = true;
    info.enable = false;
    man = {
      enable = lib.mkDefault true;
      generateCaches = lib.mkDefault true;
    };
  };
}
