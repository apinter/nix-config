{ config, pkgs, callPackage, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/system/autoupgrade.nix
      ../common/system/garbagecollect.nix
      ../common/hardware/accel.nix
      ../common/system/kernel.nix
      ../common/DE/greetd.nix
      # ../common/DE/sway.nix
      ../common/DE/hyprland.nix
      ../common/system/pipewire.nix
      ../common/hardware/bluetooth.nix
      ../common/networking/tailscale.nix
      ../common/system/btrfs.nix
      ../common/system/podman.nix
      ../common/system/nix_cfg.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/system/rtkit.nix
      ../common/system/flatpak_portals.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "umbra";
  networking.networkmanager.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
  users.users.apinter.shell = pkgs.fish;

  system.stateVersion = "23.05";
}
