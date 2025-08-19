{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = {self, nixpkgs, nixos-hardware, vscode-server, home-manager, disko, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      media = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./media/configuration.nix
          disko.nixosModules.disko
          ];
        };
      umbra = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { username = "apinter"; };
        };
        modules = [ ./umbra/configuration.nix ];
        };
      bryxina = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { username = "bryxina"; };
        };
        modules = [
          ./bryxina/configuration.nix 
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      otong = lib.nixosSystem {
        inherit system;
        modules = [
          ./otong/configuration.nix 
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-amd
          ];
        };
      sofie = lib.nixosSystem {
        inherit system;
        modules = [
          ./sofie/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.apinter = import ./home.nix;
          }
          ];
        };
      throtur = lib.nixosSystem {
        inherit system;
        modules = [
          ./throtur/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
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
        modules = [ 
          ./busybee/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
          ];
        };
      serverus = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./serverus/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      k8s00 = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { hostname = "k8s00"; };
        };
        modules = [ 
          ./k8s/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      k8s01 = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { hostname = "k8s01"; };
        };
        modules = [ 
          ./k8s/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      k8s02 = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { hostname = "k8s02"; };
        };
        modules = [ 
          ./k8s/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      };
    };
}
