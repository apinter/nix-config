{

  description = "Adathor's flake - just manages my fleet";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, disko, sops-nix, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      kazeshini = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { 
              username = "apinter";
              greeterDE = "start-hyprland"; 
            };
        };
        modules = [
          ./workstations/kazeshini/configuration.nix 
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
        specialArgs = {
            meta = { 
              username = "apinter";
              greeterDE = "start-hyprland"; 
          };
        };
        modules = [ 
          ./workstations/umbra/configuration.nix 
          home-manager.nixosModules.home-manager 
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      bryxina = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { 
              username = "bryxina";
              greeterDE = "start-hyprland"; 
            };
        };
        modules = [
          ./workstations/bryxina/configuration.nix 
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          sops-nix.nixosModules.sops
        ];
      };

      otong = lib.nixosSystem {
        inherit system;
        modules = [
          ./workstations/otong/configuration.nix 
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-amd
          ];
      };

      sofie = lib.nixosSystem {
        inherit system;
        modules = [
          ./workstations/sofie/configuration.nix
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
          ./workstations/levander/configuration.nix
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
          ./workstations/throtur/configuration.nix
          nixos-hardware.nixosModules.common-cpu-amd
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

      brenda = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules = [ ./servers/brenda/configuration.nix ];
      };

      busybee = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./servers/busybee/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          sops-nix.nixosModules.sops
        ];
      };

      serverus = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./servers/serverus/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };

      k8s00 = lib.nixosSystem {
        inherit system;
        specialArgs = {
            meta = { 
              hostname = "k8s00";
            };
        };
        modules = [ 
          ./servers/k8s/configuration.nix
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
          ./servers/k8s/configuration.nix
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
          ./servers/k8s/configuration.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
    };
  };
}
