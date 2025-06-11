{ config, pkgs, callPackage, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../common/monitoring/node-exporter.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/hardware/accel.nix
      ../common/system/garbagecollect.nix
      ../common/system/autoupgrade.nix
      ../common/DE/plasma6.nix
      ../common/hardware/fwupd.nix
      ../common/system/journald.nix
      ../common/networking/ssh.nix
      ../common/system/locales.nix
      ../common/users/nathan.nix
      ../common/users/adathor.nix
      ../common/networking/network_manager.nix
      ../common/system/btrfs.nix
      ../common/system/docker.nix
      ../common/system/podman.nix
      ../common/system/kernel.nix
      ../common/system/pipewire.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/rtkit.nix
      ../common/networking/fw_off.nix
      ../common/networking/tailscale.nix
      ../common/hardware/bluetooth.nix
      ../common/system/nix_cfg.nix
      ../common/system/flatpak_portals.nix
      ./containers.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
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
