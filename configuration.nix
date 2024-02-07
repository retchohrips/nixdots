{
  pkgs,
  userSettings,
  systemSettings,
  ...
}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  # Make fish the default shell and add aliases
  environment.shells = with pkgs; [fish];
  users.defaultUserShell = pkgs.fish;
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
    };
  };

  networking = {
    hostName = systemSettings.hostname;
    hosts = {"192.168.1.187" = ["cuddlenode"];};
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";
  time.hardwareClockInLocalTime = true; # Compatibility with Windows clock for dualbooting

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;

    # Configure keymap
    xkb.layout = "us";
    xkb.variant = "";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      cheese # Webcam tool
      gnome-terminal
      gnome-music
      epiphany # Web browser
      yelp # Help viewer
      gnome-maps
    ]);

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel"];
  };

  # This makes VSCode work on wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # File fetching
    wget
    curl

    # VCS
    git
    pre-commit
    commitizen

    # Cli tools
    eza
    unzip
    ripgrep
    fishPlugins.puffer

    # Package management
    nodejs
    cargo
    nodePackages.pnpm
  ];

  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

  services.syncthing = {
    enable = true;
    dataDir = "/home/${userSettings.username}";
    user = "${userSettings.username}";
    settings = {
      folders = {
        Music = {
          enable = true;
          devices = ["S23"];
          label = "Music";
          id = "jfvxq-2lb67";
          path = "/home/${userSettings.username}/Music";
        };
        Obsidian = {
          enable = true;
          devices = ["S23"];
          label = "Obsidian";
          id = "pnweh-uhtt2";
          path = "/home/${userSettings.username}/Documents/Obsidian";
        };
      };
      options = {
        relaysEnabled = true;
        urAccepted = -1;
      };
      devices = {S23 = {id = "RP3YA5P-EXN4AAG-JAMUDCL-C7GTHE4-SSTGPKC-LSD6UJH-WIBQSVM-K5IXFAN";};};
    };
  };

  # Collect garbage
  nix.gc = {
    automatic = true;
    options = "-d";
    dates = "48hr";
  };

  # Automatic updates
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # Print build logs
    ];
    dates = "24hr";
    randomizedDelaySec = "45min";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
