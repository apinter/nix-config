{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, nixos-hardware, home-manager, disko, sops-nix, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      kazeshini = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { username = "apinter"; };
        };
        modules = [
          ./kazeshini/configuration.nix 
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-amd
          ];
        };
      media = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./media/configuration.nix
          disko.nixosModules.disko
          ];
        };
      umbra = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./umbra/configuration.nix 
          home-manager.nixosModules.home-manager 
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
        };
      bryxina = lib.nixosSystem {
        inherit system;
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
      levander = lib.nixosSystem {
        inherit system;
        modules = [
          ./levander/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-amd
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
          disko.nixosModules.disko
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
          sops-nix.nixosModules.sops
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
