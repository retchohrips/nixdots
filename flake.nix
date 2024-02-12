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

    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs = {
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
        systemSettings = {
          hostname = "bundesk";
        };
        userSettings = {
          username = "bunny";
          name = "Bun";
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
          user = "puppy";
          name = "Pup";
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
