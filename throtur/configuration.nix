{ modulesPath, config, pkgs, callPackage, ... }:
{
  imports =
  [
      ../modules/monitoring/node-exporter.nix
      ../modules/systemd-user/flatpak-auto-update.nix
      ../modules/hardware/accel.nix
      ../modules/system/garbagecollect.nix
      ../modules/system/autoupgrade.nix
      ../modules/DE/plasma6.nix
      ../modules/hardware/fwupd.nix
      ../modules/system/journald.nix
      ../modules/system/locales.nix
      ../modules/system/locales.nix
      ../modules/users/adathor.nix
      ../modules/users/throtur.nix
      ../modules/networking/tailscale.nix
      ../modules/networking/network_manager.nix
      ../modules/system/btrfs.nix
      ../modules/system/podman.nix
      ../modules/system/kernel.nix
      ../modules/system/pipewire.nix
      ../modules/system/systemd-boot.nix
      ../modules/system/zram.nix
      ../modules/system/rtkit.nix
      ../modules/networking/fw_off.nix
      ../modules/hardware/bluetooth.nix
      ../modules/system/nix_cfg.nix
      ../modules/system/flatpak_portals.nix
      ../modules/networking/ssh.nix
      ../modules/system/plymouth.nix
      ./disk-config.nix
  ];

  networking.hostName = "throtur";
  
  fileSystems."/home/throtur/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/apinter_jr";
      fsType = "nfs";
  };

  system.stateVersion = "23.05";
}
