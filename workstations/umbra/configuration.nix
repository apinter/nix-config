{ config, pkgs, callPackage,meta, ... }:

{
  imports =
    [ 
      ../../modules/systemd-user/flatpak-auto-update.nix
      ../../modules/system/autoupgrade.nix
      ../../modules/system/garbagecollect.nix
      ../../modules/hardware/accel.nix
      ../../modules/system/kernel.nix
      ../../modules/DE/hyprland.nix
      ../../modules/system/pipewire.nix
      ../../modules/hardware/bluetooth.nix
      ../../modules/networking/tailscale.nix
      ../../modules/system/btrfs.nix
      ../../modules/system/podman.nix
      ../../modules/system/nix_cfg.nix
      ../../modules/system/systemd-boot.nix
      ../../modules/system/zram.nix
      ../../modules/system/locales.nix
      ../../modules/users/adathor.nix
      ../../modules/system/rtkit.nix
      ../../modules/system/flatpak_portals.nix
      ../../modules/DE/greetd.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "umbra";
  networking.networkmanager.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
  users.users.apinter.shell = pkgs.fish;

  services = {
    syncthing = {
      enable = true;
      user = "apinter";
      dataDir = "/home/apinter/Project/Syncthing";
      configDir = "/home/apinter/Project/Syncthing/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "kazeshini" = { id = "XQYSUS5-HNIL4J5-YWGYXM7-TRUCXBD-3U3TPXG-TKMZY5G-7FGTKTY-4J744AL"; };
        };
        folders = {
          "common" = {
            id = "kca9y-ijdui";
            path = "/home/apinter/Project/Syncthing/common";
            type = "sendreceive";
            devices = [
              "kazeshini"
            ];
          };
        };
      };
    };
  };

  system.stateVersion = "23.05";
}
