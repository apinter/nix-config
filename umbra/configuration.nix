{ config, pkgs, callPackage, meta, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/system/autoupgrade.nix
      ../common/system/garbagecollect.nix
      ../common/hardware/accel.nix
      ../common/system/kernel.nix
      # ../common/DE/sway.nix
      ../common/DE/hyprland.nix
      ../common/system/pipewire.nix
      ../common/hardware/bluetooth.nix
      ../common/networking/tailscale.nix
      ../common/system/btrfs.nix
      ../common/system/podman.nix
      ../common/system/nix_cfg.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/system/rtkit.nix
      ../common/system/flatpak_portals.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
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
