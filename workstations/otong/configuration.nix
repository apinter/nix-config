{ config, pkgs, callPackage, ... }:
{
  imports =
    [
      ../../modules/monitoring/node-exporter.nix
      ../../modules/systemd-user/flatpak-auto-update.nix
      ../../modules/hardware/accel.nix
      ../../modules/system/garbagecollect.nix
      ../../modules/system/autoupgrade.nix
      ../../modules/DE/gnome.nix
      ../../modules/hardware/fwupd.nix
      ../../modules/system/journald.nix
      ../../modules/networking/ssh.nix
      ../../modules/system/locales.nix
      ../../modules/users/nathan.nix
      ../../modules/users/adathor.nix
      ../../modules/users/devops_group.nix
      ../../modules/networking/network_manager.nix
      ../../modules/system/btrfs.nix
      ../../modules/system/docker.nix
      ../../modules/system/podman.nix
      ../../modules/system/kernel.nix
      ../../modules/system/pipewire.nix
      ../../modules/system/systemd-boot.nix
      ../../modules/system/zram.nix
      ../../modules/system/rtkit.nix
      ../../modules/networking/fw_off.nix
      ../../modules/networking/tailscale.nix
      ../../modules/hardware/bluetooth.nix
      ../../modules/system/nix_cfg.nix
      ../../modules/system/flatpak_portals.nix
      ../../modules/system/printer_user.nix
      ../../modules/system/plymouth.nix
      ../../modules/system/avahi.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "otong";

  fileSystems."/home/nathan/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/nathan";
      fsType = "nfs";
  };

  fileSystems."/home/nathan/SteamData" = {
      device = "/dev/disk/by-label/STEAM";
      fsType = "btrfs";
      options = [ "subvol=Steam" "compress=zstd:1" ];
  };

  system.stateVersion = "23.05";
  hardware.steam-hardware.enable = true;
}
