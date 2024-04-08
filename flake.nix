{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    stylix.url = "github:danth/stylix";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    betterfox = {
      url = "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js";
      flake = false;
    };

    # anyrun program launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    beets-lastloved = {
      url = "github:retchohrips/lastloved";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    commonSettings = {
      browser = "firefox";
      terminal = "kitty";
      font = "CaskaydiaCove";
      theme = "catppuccin-frappe";
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
          genPape = "yes";
          pape = "flowers.jpg";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs userSettings systemSettings;
          };
          modules = [
            ./hosts/${systemSettings.hostname}
            ./modules
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home;

                extraSpecialArgs = {
                  inherit inputs userSettings systemSettings;
                };
              };
            }
          ];
        };
      pawpad = let
        systemSettings = {
          hostname = "pawpad";
        };
        userSettings = {
          inherit (commonSettings) browser terminal font theme;
          username = "puppy";
          name = "Pup";
          dewm = "hyprland";
          genPape = "yes";
          pape = "Y2K.png";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs userSettings systemSettings;
          };
          modules = [
            ./hosts/${systemSettings.hostname}
            ./modules
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.dell-inspiron-5509
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home;

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
