{ config, pkgs, callPackage, ... }:

{
  imports =
    [
      ../common/monitoring/node-exporter.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/hardware/accel.nix
      ../common/system/gitea-runner.nix
      ../common/system/garbagecollect.nix
      ../common/system/autoupgrade.nix
      ../common/DE/plasma6.nix
      ../common/system/printer.nix
      ../common/hardware/fwupd.nix
      ../common/system/journald.nix
      ../common/networking/ssh.nix
      ../common/system/locales.nix
      ../common/users/sofie.nix
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
      ./hardware-configuration.nix
      # ./containers.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "sofie";

  fileSystems."/home/sofie/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/sofie";
      fsType = "nfs";
  };

  fileSystems."/home/sofie/VMs" = {
      device = "/dev/disk/by-uuid/4cca616f-6396-4baa-9370-a2b345b9c57c";
      fsType = "btrfs";
      options = [ "compress=zstd:1" ];
  };

  environment.systemPackages = with pkgs; [
    pkgs.sane-backends
    pkgs.gutenprint
    pkgs.brlaser
    pkgs.brscan5
    pkgs.brscan4
  ];

  system.stateVersion = "23.05";
}
