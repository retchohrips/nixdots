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

    hyprland.url = "github:hyprwm/Hyprland";
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

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
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
  in {
    nixosConfigurations = {
      bundesk = let
        userSettings = {
          username = "bunny";
          name = "Bun";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs userSettings;
          };
          modules = [
            ./hosts/bundesk
            ./modules
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home;

                extraSpecialArgs = {
                  inherit inputs userSettings;
                };
              };
            }
          ];
        };
      pawpad = let
        userSettings = {
          username = "puppy";
          name = "Pup";
        };
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs userSettings;
          };
          modules = [
            ./hosts/pawpad
            ./modules
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.dell-inspiron-5509
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} = import ./home;

                extraSpecialArgs = {
                  inherit inputs userSettings;
                };
              };
            }
          ];
        };
    };
  };
}
