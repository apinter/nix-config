{ modulesPath, config, lib, pkgs, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      ../common/system/garbagecollect.nix
      ../common/DE/server_packages.nix
      ../common/system/journald.nix
      ../common/networking/ssh.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/system/btrfs.nix
      ../common/system/docker.nix
      ../common/system/podman.nix
      ../common/system/zram.nix
      ../common/system/rtkit.nix
      ../common/networking/network_manager.nix
      ../common/networking/tailscale.nix
      ../common/networking/fw_off.nix
      ../common/system/nix_cfg.nix
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
