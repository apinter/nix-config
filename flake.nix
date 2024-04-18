{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
    home-manager.url = "github:nix-community/home-manager/master";
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
        modules = [ 
          ./throtur/configuration.nix 
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.apinter = import ./home.nix;
          }
        ];
        };
      otong = lib.nixosSystem {
        inherit system;
        modules = [ ./otong/configuration.nix ];
        };
      busybee = lib.nixosSystem {
        inherit system;
        modules = [ ./busybee/configuration.nix ];
        };
      };
    };
  };
}
