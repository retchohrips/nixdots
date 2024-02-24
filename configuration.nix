{
  pkgs,
  userSettings,
  systemSettings,
  inputs,
  ...
}: {
  imports = [
    ./system/hardware/bluetooth.nix
    ./system/hardware/kernel.nix
    ./system/hardware/opengl.nix
    ./system/hardware/printing.nix
    ./system/hardware/time.nix

    ./system/security/automount.nix
    ./system/security/doas.nix
    ./system/security/networking.nix

    ./system/cleaning.nix
    ./system/fonts.nix
    ./system/syncthing.nix

    ./system/gaming.nix

    ./system/dewm/${userSettings.dewm}.nix
  ];

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
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];

      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment = {
    # Make fish the default shell
    shells = with pkgs; [fish];

    # This makes VSCode work on wayland
    sessionVariables.NIXOS_OZONE_WL = "1";

    # Packages installed in system profile
    systemPackages = with pkgs; [
      wget
      curl
      git
      cachix # Fetch cached binaries

      gcc # Home manager must be able to compile C

      ffmpeg
    ];
  };

  # Make fish the default shell
  users.defaultUserShell = pkgs.fish;

  programs = {
    fish.enable = true;
    dconf.enable = true;
  };

  networking = {
    hostName = systemSettings.hostname;
    hosts = {"192.168.1.187" = ["cuddlenode"];};
    networkmanager = {
      enable = true;
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            /*
            bash
            */
            ''
              ${pkgs.greetd.tuigreet}/bin/tuigreet \
                      --time --user-menu --remember --remember-user-session \
                      --cmd Hyprland
            '';
          user = "greeter";
        };
      };
    };

    xserver = {
      enable = true;

      # Configure keymap
      xkb.layout = "us";
      xkb.variant = "";

      # do not install xterm
      excludePackages = with pkgs; [xterm];
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs = {
    overlays = [inputs.nur.overlay];

    config = {
      allowUnfree = true;

      # Allows Obsidian to be installed
      permittedInsecurePackages = ["electron-25.9.0"];
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
