{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11"; 
    home-manager.url = "github:nix-community/home-manager/release-23.11";
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
      brenda = lib.nixosSystem {
        inherit system;
        modules = [ ./brenda/configuration.nix ];
        };
      sofie = lib.nixosSystem {
        inherit system;
        modules = [ ./sofie/configuration.nix ];
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
