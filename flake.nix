{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-colors.url = "github:misterio77/nix-colors";

    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons";
      flake = false;
    };

    astronvim = {
      url = "github:AstroNvim/AstroNvim/main";
      flake = false;
    };

    hyprlock = {
      url = "github:retchohrips/hyprlock"; # TODO: Temporary until this (hopefully) gets merged
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-kitty = {
      url = "github:catppuccin/kitty";
      flake = false;
    };

    # firefox-gnome-theme = {
    #   url = "github:rafaelmardojai/firefox-gnome-theme";
    #   flake = false;
    # };
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
          pape = "BLACK_X_desktop.jpg";
          browser = "brave";
          font = "JetBrainsMono Nerd Font";
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
            ./hosts/bundesk
            home-manager.nixosModules.home-manager

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home.nix;

                extraSpecialArgs = {
                  inherit userSettings;
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
          pape = "BLACK_X_desktop.jpg";
          browser = "brave";
          font = "CommitMono";
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
            ./hosts/pawpad
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.dell-inspiron-5509
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home.nix;

                extraSpecialArgs = {
                  inherit userSettings;
                  inherit inputs;
                };
              };
            }
          ];
        };
    };
  };
}
