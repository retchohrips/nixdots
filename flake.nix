{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    nix-colors.url = "github:misterio77/nix-colors";

    stylix.url = "github:danth/stylix";

    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons";
      flake = false;
    };

    astronvim = {
      url = "github:AstroNvim/AstroNvim/main";
      flake = false;
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox-gnome-theme = {
    #   url = "github:rafaelmardojai/firefox-gnome-theme";
    #   flake = false;
    # };
  };

  outputs = {
    nixpkgs,
    nur,
    stylix,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      bundesk = let
        systemSettings = {
          hostname = "bundesk";
        };
        userSettings = {
          username = "bunny";
          name = "Bun";
          dewm = "hyprland";
          pape = "Kurzgesagt-Galaxies.png";
          browser = "firefox";
          terminal = "foot";
          font = "VictorMono Nerd Font";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
          modules = [
            nur.nixosModules.nur
            ./configuration.nix
            ./hosts/${systemSettings.hostname}
            home-manager.nixosModules.home-manager
            inputs.nix-flatpak.nixosModules.nix-flatpak
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home.nix;

                extraSpecialArgs = {
                  inherit userSettings;
                  inherit systemSettings;
                  inherit inputs;
                };
              };
            }
          ];
        };

      pawpad = let
        systemSettings = {hostname = "pawpad";};
        userSettings = {
          username = "puppy";
          name = "Pup";
          dewm = "hyprland";
          pape = "mandelbrot_gap_blue.png";
          browser = "firefox";
          terminal = "foot";
          font = "VictorMono Nerd Font";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
          modules = [
            nur.nixosModules.nur
            ./configuration.nix
            ./hosts/${systemSettings.hostname}
            home-manager.nixosModules.home-manager
            inputs.nix-flatpak.nixosModules.nix-flatpak
            nixos-hardware.nixosModules.dell-inspiron-5509
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home.nix;

                extraSpecialArgs = {
                  inherit userSettings;
                  inherit systemSettings;
                  inherit inputs;
                };
              };
            }
          ];
        };
    };
  };
}
