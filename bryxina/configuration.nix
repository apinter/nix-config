{ config, pkgs, callPackage, modulesPath, ... }:

{
  imports =
    [
      ../common/system/nix_cfg.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/system/gitea-runner.nix
      ../common/monitoring/node-exporter.nix
      ../common/hardware/accel.nix
      ../common/system/garbagecollect.nix
      ../common/system/autoupgrade.nix
      ../common/DE/plasma6.nix
      ../common/hardware/fwupd.nix
      ../common/system/journald.nix
      ../common/networking/ssh.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/users/bryxina.nix
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
      ../common/hardware/bluetooth.nix
      ./hardware-configuration.nix
      # ./containers.nix
    ];

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "bryxina";
  
  fileSystems."/home/bryxina/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/skye";
      fsType = "nfs";
  };

  system.stateVersion = "23.05"; 
}
