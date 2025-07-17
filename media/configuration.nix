{ modulesPath, hconfig, pkgs, callPackage, ... }:

{
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
      # ./hardware-configuration.nix
      ../common/DE/sway.nix
      ../common/hardware/accel.nix
      ../common/users/adathor.nix
      ../common/users/media.nix
      ../common/hardware/bluetooth.nix
      ../common/networking/tailscale.nix
      ../common/system/pipewire.nix
      ../common/system/autoupgrade.nix
      ../common/system/garbagecollect.nix
      ../common/system/btrfs.nix
      ../common/system/podman.nix
      ../common/system/nix_cfg.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/locales.nix
      ../common/system/rtkit.nix
      ../common/system/flatpak_portals.nix
      ../common/systemd-user/flatpak-auto-update.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "media";
  networking.networkmanager.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
  users.users.apinter.shell = pkgs.fish;
  environment.systemPackages = with pkgs; [ 
    pkgs.libcec
  ];

  system.stateVersion = "23.05";
}
