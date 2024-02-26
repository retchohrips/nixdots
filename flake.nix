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
    stylix.url = "github:danth/stylix";

    ranger-devicons.url = "github:alexanderjeurissen/ranger_devicons";
    ranger-devicons.flake = false;

    astronvim.url = "github:AstroNvim/AstroNvim/main";
    astronvim.flake = false;

    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";

    hypridle.url = "github:hyprwm/hypridle";
    hypridle.inputs.nixpkgs.follows = "nixpkgs";

    # firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";
    # firefox-gnome-theme.flake = false;
  };

  outputs = {
    nixpkgs,
    nur,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    commonSettings = {
      browser = "firefox";
      terminal = "foot";
      font = "VictorMono";
      theme = "catppuccin-mocha";
    };
  in {
    nixosConfigurations = {
      bundesk = let
        systemSettings = {
          hostname = "bundesk";
        };
        userSettings = {
          inherit (commonSettings) browser terminal font theme;
          username = "bunny";
          name = "Bun";
          dewm = "hyprland";
          pape = "Kurzgesagt-Galaxies.png";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs userSettings systemSettings;
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
                  inherit inputs userSettings systemSettings;
                };
              };
            }
          ];
        };

      pawpad = let
        systemSettings = {hostname = "pawpad";};
        userSettings = {
          inherit (commonSettings) browser terminal font theme;
          username = "puppy";
          name = "Pup";
          dewm = "hyprland";
          pape = "mandelbrot_gap_blue.png";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs userSettings systemSettings;
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
                  inherit inputs userSettings systemSettings;
                };
              };
            }
          ];
        };
    };
  };
}
