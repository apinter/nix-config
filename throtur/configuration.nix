{ config, pkgs, callPackage, ... }:
{
  imports =
  [
      ../common/monitoring/node-exporter.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/hardware/accel.nix
      ../common/system/garbagecollect.nix
      ../common/system/autoupgrade.nix
      ../common/DE/plasma6.nix
      ../common/hardware/fwupd.nix
      ../common/system/journald.nix
      ../common/system/locales.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/users/throtur.nix
      ../common/networking/tailscale.nix
      ../common/networking/network_manager.nix
      ../common/system/btrfs.nix
      # ../common/system/docker.nix
      ../common/system/podman.nix
      ../common/system/kernel.nix
      ../common/system/pipewire.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/rtkit.nix
      ../common/networking/fw_off.nix
      ../common/hardware/bluetooth.nix
      ../common/system/nix_cfg.nix
      ../common/system/flatpak_portals.nix
      ../common/networking/ssh.nix
      ../common/system/plymouth.nix
      ./hardware-configuration.nix
  ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "throtur";
  
  fileSystems."/home/throtur/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/apinter_jr";
      fsType = "nfs";
  };

  system.stateVersion = "23.05";
}
