{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11"; 
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      umbra = lib.nixosSystem {
        inherit system;
        modules = [ ./umbra/configuration.nix ];
        };
      brenda = lib.nixosSystem {
        inherit system;
        modules = [ ./brenda/configuration.nix ];
        };
      sofie = lib.nixosSystem {
        inherit system;
        modules = [ ./sofie/configuration.nix ];
        };
      bryxina = lib.nixosSystem {
        inherit system;
        modules = [ ./bryxina/configuration.nix ];
        };
      throtur = lib.nixosSystem {
        inherit system;
        modules = [ ./throtur/configuration.nix ];
        };
      otong = lib.nixosSystem {
        inherit system;
        modules = [ ./otong/configuration.nix ];
        };
      crate = lib.nixosSystem {
        inherit system;
        modules = [ ./crate/configuration.nix ];
        };
      };
    homeConfigurations = {
      apinter = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./umbra/home.nix ];
      };
    };
  };
}
