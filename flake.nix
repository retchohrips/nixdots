{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixpkgs-nixvim-hack.url = "github:nixos/nixpkgs/a4d4fe8c5002202493e87ec8dbc91335ff55552c"; #HACK nixOS-unstable breaks nixvim currently - see https://github.com/nix-community/nixvim/issues/1112

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-nixvim-hack"; #HACK nixOS-unstable breaks nixvim currently - see https://github.com/nix-community/nixvim/issues/1112
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ranger-devicons = {
      url = "github:alexanderjeurissen/ranger_devicons";
      flake = false;
    };

    # firefox-gnome-theme = {
    #   url = "github:rafaelmardojai/firefox-gnome-theme";
    #   flake = false;
    # };
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
