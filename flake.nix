{

  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    astronvim = { url = "github:AstroNvim/AstroNvim/v3.42.0"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
    nixosConfigurations = {
      BUNVM = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bunny = import ./home.nix;
            home-manager.extraSpecialArgs = attrs;
          }
        ];
      };
    };
  };

}
