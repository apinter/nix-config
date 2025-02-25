{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11"; 
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {self, nixpkgs, nixos-hardware, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      brenda = lib.nixosSystem {
        inherit system;
        modules = [ ./brenda/configuration.nix ];
        };
      };
  };
}
