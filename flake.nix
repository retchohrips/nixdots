{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    astronvim = {
      url = "github:AstroNvim/AstroNvim/main";
      flake = false;
    };

    stylix.url = "github:danth/stylix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    stylix,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    systemSettings = rec {
      system = "x86_64-linux";
      hostname = "pawpad";
    };
    userSettings = rec {
      username = "puppy";
      name = "Pup";
    };
  in {
    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit userSettings;
          inherit systemSettings;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          nixos-hardware.nixosModules.dell-inspiron-5509
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userSettings.username} = import ./home.nix;
            stylix.image = ./wallpapers/Makima_Persona.png;
            home-manager.extraSpecialArgs = {
              inherit userSettings;
              inherit (inputs) astronvim;
              inherit stylix;
            };
          }
        ];
      };
    };
  };
}
