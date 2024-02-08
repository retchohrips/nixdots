{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    astronvim = {
      url = "github:AstroNvim/AstroNvim/main";
      flake = false;
    };

    # stylix.url = "github:danth/stylix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    # stylix,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
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
        };
      in
        lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            ./hosts/bundesk
            home-manager.nixosModules.home-manager
            # stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = import ./home.nix;
              # stylix.image = ./wallpapers/Makima_Persona.png;
              home-manager.extraSpecialArgs = {
                inherit userSettings;
                inherit inputs;
                # inherit stylix;
              };
            }
          ];
        };

      pawpad = let
        systemSettings = {hostname = "pawpad";};
        userSettings = {
          user = "puppy";
          name = "Pup";
        };
      in
        lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            ./hosts/pawpad
            home-manager.nixosModules.home-manager
            # stylix.nixosModules.stylix
            nixos-hardware.nixosModules.dell-inspiron-5509
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = import ./home.nix;
              # stylix.image = ./wallpapers/Makima_Persona.png;
              home-manager.extraSpecialArgs = {
                inherit userSettings;
                inherit inputs;
                # inherit stylix;
              };
            }
          ];
        };
    };
  };
}
