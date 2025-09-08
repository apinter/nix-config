{ modulesPath, config, lib, pkgs, meta, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
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
      ../common/users/sofie.nix
      ../common/users/adathor.nix
      ../common/networking/network_manager.nix
      ../common/system/btrfs.nix
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
      ./disk-config.nix
      # ./containers.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "levander";

  powerManagement.resumeCommands = "${pkgs.kmod}/bin/rmmod atkbd; ${pkgs.kmod}/bin/modprobe atkbd reset=1";
  boot.plymouth.enable = true;

  system.stateVersion = "23.05";
}
