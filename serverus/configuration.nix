{ modulesPath, config, lib, pkgs, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      ../modules/system/garbagecollect.nix
      ../modules/DE/server_packages.nix
      ../modules/system/journald.nix
      ../modules/networking/ssh.nix
      ../modules/system/locales.nix
      ../modules/users/adathor.nix
      ../modules/system/btrfs.nix
      ../modules/system/docker.nix
      ../modules/system/podman.nix
      ../modules/system/zram.nix
      ../modules/system/rtkit.nix
      ../modules/networking/network_manager.nix
      ../modules/networking/tailscale.nix
      ../modules/networking/fw_off.nix
      ../modules/system/nix_cfg.nix
      ./autoupgrade.nix
      ./disk-config.nix
      ./containers.nix
      ./wireguard.nix
      ./node-exporter.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial
  '';
  networking.hostName = "serverus";
  networking.hostId = "ffc4c072";

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.redis.vmOverCommit = true;

  system.stateVersion = "23.11";
}
