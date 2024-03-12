{
  pkgs,
  userSettings,
  systemSettings,
  inputs,
  ...
}: {
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
  };

  nix = {
    settings = {
      trusted-users = [userSettings.username];
      # Caches to pull from so we don't have to build packages
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment = {
    # Make fish the default shell
    shells = with pkgs; [fish];

    systemPackages = with pkgs; [
      wget
      curl
      git
      cachix # Fetch cached binaries
    ];
  };

  # Make fish the default shell
  users.defaultUserShell = pkgs.fish;

  programs = {
    fish.enable = true;
  };

  networking = {
    hostName = systemSettings.hostname;
    hosts = {"192.168.1.187" = ["cuddlenode"];};
    networkmanager = {
      enable = true;
    };
  };

  # Define a user account.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  nixpkgs = {
    overlays = [inputs.nur.overlay];

    config = {
      allowUnfree = true;
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
