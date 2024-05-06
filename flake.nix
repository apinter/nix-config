{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {self, nixpkgs, nixos-hardware, home-manager, ...}:
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
      bryxina = lib.nixosSystem {
        inherit system;
        modules = [ ./bryxina/configuration.nix ];
        };
      throtur = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./throtur/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
          # nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.apinter = import ./home.nix;
          }
          ];
        };
      busybee = lib.nixosSystem {
        inherit system;
        modules = [ ./busybee/configuration.nix ];
        };
      };
    };
}
