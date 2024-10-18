{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./zfs_pool.nix
      ./autoupgrade.nix
      ./monitoring.nix
      ./exports.nix 
      ./garbagecollect.nix
      ./containers.nix
    ];

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/disk/by-id/ata-RX7_2.5_128GB_AA000000000000000897" ];
  boot.loader.grub.zfsSupport = true;
  boot.loader.grub.memtest86.enable = true;
  boot.loader.grub.efiSupport = false;
  security.rtkit.enable = true;
  zramSwap.enable = true;
  networking.hostName = "brenda";
  networking.networkmanager.enable = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportAll = false;
  networking.hostId = "d1a3152c";

  time.timeZone = "Asia/Jakarta";

  users.users.apinter = {
    isNormalUser = true;
    home = "/home/apinter";
    description = "Attila Pinter";
    extraGroups = [ "wheel" "devops" ];
    openssh.authorizedKeys.keys = [ 
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINYgL/PMWtjixH8gzkXuuU03GcgdXFNXfX42HuFGGoHGAAAABHNzaDo= tw.kazeshini-30-03-2024-adathor-yubikeyA" 
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIEGr9vLSNBrHSY2RwFHpkXWSCGPtvRqxgVLKduww+1FAAAAABHNzaDo= tw.kazeshini-30-03-2024-adathor-yubikeyC" 
    ];
    linger = true;
  };

  security.sudo.extraRules = [
    {
      groups = [ "devops" ];
      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];
  
  users.groups.devops.gid = 5000;

  environment.systemPackages = with pkgs; [
    vim 
    curl
    htop
    cryptsetup
    git
    ranger
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
      autoPrune.enable = true;
    };
  };
  
  virtualisation.oci-containers.backend = "podman";
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.nfs.server = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };
  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11";
}

