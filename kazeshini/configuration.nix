{ config, pkgs, callPackage, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/monitoring/node-exporter.nix
      ../modules/systemd-user/flatpak-auto-update.nix
      ../modules/hardware/accel.nix
      ../modules/system/garbagecollect.nix
      ../modules/system/autoupgrade.nix
      ../modules/DE/gnome.nix
      ../modules/system/fonts.nix
      ../modules/hardware/fwupd.nix
      ../modules/system/journald.nix
      ../modules/networking/ssh.nix
      ../modules/system/locales.nix
      ../modules/users/adathor.nix
      ../modules/users/podman.nix
      ../modules/networking/network_manager.nix
      ../modules/system/btrfs.nix
      ../modules/system/docker.nix
      ../modules/system/podman.nix
      ../modules/system/kernel.nix
      ../modules/system/pipewire.nix
      ../modules/system/systemd-boot.nix
      ../modules/system/zram.nix
      ../modules/system/rtkit.nix
      ../modules/networking/fw_off.nix
      ../modules/networking/tailscale.nix
      ../modules/hardware/bluetooth.nix
      ../modules/system/nix_cfg.nix
      ../modules/system/flatpak_portals.nix
      ../modules/system/plymouth.nix
      ../modules/system/avahi.nix
      ../modules/system/libvirt.nix
      ../modules/system/cockpit.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.initrd.kernelModules = [ "amdgpu" ];
  networking.hostName = "kazeshini";

  fileSystems."/home/apinter/Steam" = {
      device = "/dev/disk/by-label/SSData";
      fsType = "btrfs";
      options = [ "subvol=Steam" "compress=zstd:1" ];
  };

  fileSystems."/home/apinter/Storage" = {
      device = "/dev/disk/by-label/Stora0";
      fsType = "btrfs";
      options = [ "subvol=Stora" "compress=zstd:1" ];
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  programs.fish.enable = true;
  users.users.apinter.shell = pkgs.fish;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "25.05";
  hardware.steam-hardware.enable = true;
}
