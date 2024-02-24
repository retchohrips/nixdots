{
  pkgs,
  userSettings,
  systemSettings,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.steamCompat
  ];

  nix = {
    # Collect garbage
    gc = {
      automatic = true;
      options = "--delete-older-than 1w";
      dates = "weekly";
    };

    # Automatic store optimisation
    optimise = {
      automatic = true;
      dates = ["03:45"];
    };

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

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = ["ntfs"];
    plymouth.enable = true;
  };

  environment = {
    # Make fish the default shell
    shells = with pkgs; [fish];

    # Do not install these packages that are normally included with gnome
    gnome.excludePackages =
      (with pkgs; [gnome-tour gnome-console])
      ++ (with pkgs.gnome; [
        gnome-calendar
        geary # mail
        cheese # Webcam tool
        gnome-terminal
        epiphany # Web browser
        yelp # Help viewer
        gnome-maps
      ]);

    # This makes VSCode work on wayland
    sessionVariables.NIXOS_OZONE_WL = "1";

    # Packages installed in system profile
    systemPackages = with pkgs; [
      # File fetching
      wget
      curl

      # VCS
      git
      git-crypt
      pre-commit
      commitizen

      # Cli tools
      eza
      unzip
      p7zip
      ripgrep
      fishPlugins.puffer
      fishPlugins.bass
      fishPlugins.sponge
      fishPlugins.pisces
      fishPlugins.colored-man-pages
      cachix # Fetch cached binaries

      # Package management
      nodejs
      cargo
      nodePackages.pnpm

      ffmpeg
      libnotify
      networkmanagerapplet
      pulseaudio
      rofi-bluetooth

      gcc # Home manager must be able to compile C...
    ];
  };

  # Make fish the default shell
  users.defaultUserShell = pkgs.fish;

  programs = {
    hyprland.enable =
      if (userSettings.dewm == "hyprland")
      then true
      else false;
    fish.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = [inputs.nix-gaming.packages.${pkgs.system}.proton-ge];
    };
    gamemode.enable = true;
  };

  networking = {
    hostName = systemSettings.hostname;
    hosts = {"192.168.1.187" = ["cuddlenode"];};
    nameservers = ["127.0.0.1" "::1"];
    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall = {enable = true;};
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy";

  hardware.bluetooth.enable = true;

  time.timeZone = "America/New_York";
  time.hardwareClockInLocalTime =
    true; # Compatibility with Windows clock for dualbooting

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

  services = {
    # blueman.enable = true;
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

      desktopManager.gnome.enable =
        if (userSettings.dewm == "gnome")
        then true
        else false;

      # do not install xterm
      excludePackages = with pkgs; [xterm];
    };

    printing.enable = true; # Enable CUPS to print documents

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    syncthing = {
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
        devices = {
          S23 = {
            id = "RP3YA5P-EXN4AAG-JAMUDCL-C7GTHE4-SSTGPKC-LSD6UJH-WIBQSVM-K5IXFAN";
          };
        };
      };
    };
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

    lowLatency = {enable = true;};
  };

  # Define a user account.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel"];
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["${userSettings.font}" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Inter" "Noto Color Emoji"];
      };
      antialias = true; # Fix pixelation
      hinting = {
        # Fix antialiasing blur
        enable = true;
        autohint = true;
        style = "full";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };

  nixpkgs.overlays = [inputs.nur.overlay];

  nixpkgs.config = {
    allowUnfree = true;

    # Allow obsidian to be installed
    permittedInsecurePackages = ["electron-25.9.0"];
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
    dates = "2:00";
    randomizedDelaySec = "45min";
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
