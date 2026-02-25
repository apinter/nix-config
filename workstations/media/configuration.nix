{ modulesPath, hconfig, pkgs, callPackage, ... }:

{
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
      ../../modules/DE/sway.nix
      ../../modules/hardware/accel.nix
      ../../modules/users/adathor.nix
      ../../modules/users/media.nix
      ../../modules/hardware/bluetooth.nix
      ../../modules/networking/tailscale.nix
      ../../modules/system/pipewire.nix
      ../../modules/system/autoupgrade.nix
      ../../modules/system/garbagecollect.nix
      ../../modules/system/podman.nix
      ../../modules/system/nix_cfg.nix
      ../../modules/system/systemd-boot.nix
      ../../modules/system/zram.nix
      ../../modules/system/locales.nix
      ../../modules/system/rtkit.nix
      ../../modules/system/flatpak_portals.nix
      ../../modules/networking/ssh.nix
      ../../modules/systemd-user/flatpak-auto-update.nix
      ./disk-config.nix
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
  documentation.man.generateCaches = false;

  system.stateVersion = "23.05";
}
