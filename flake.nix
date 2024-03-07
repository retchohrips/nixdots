{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      # url = "github:nix-community/home-manager";
      # https://github.com/nix-community/home-manager/issues/4912
      url = "github:xopclabs/home-manager/floorp-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-flatpak.url = "github:gmodena/nix-flatpak/main";
    stylix.url = "github:danth/stylix";

    ranger-devicons.url = "github:alexanderjeurissen/ranger_devicons";
    ranger-devicons.flake = false;

    astronvim.url = "github:AstroNvim/AstroNvim/main";
    astronvim.flake = false;

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    neovim-flake.url = "github:notashelf/neovim-flake";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";

    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";

    hypridle.url = "github:hyprwm/hypridle";
    hypridle.inputs.nixpkgs.follows = "nixpkgs";

    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";
    firefox-gnome-theme.flake = false;

    one-fox.url = "github:Perseus333/One-Fox";
    one-fox.flake = false;
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
      browser = "floorp";
      terminal = "kitty";
      font = "JetBrainsMono";
      theme = "gruvbox-material-dark-medium";
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
          genPape = "yes";
          pape = "Y2K.png";
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
