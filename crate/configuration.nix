{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./monitoring.nix
      ./autoupgrade.nix
      ./garbagecollect.nix
      # ./nebula.nix
      ./systemd.nix
    ];

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  security.rtkit.enable = true;
  zramSwap.enable = true;
  networking.hostName = "crate";
  networking.networkmanager.enable = true;
  networking.hostId = "ae21239e";

  time.timeZone = "Asia/Jakarta";

  users.users.apinter = {
    isNormalUser = true;
    home = "/home/apinter";
    description = "Attila Pinter";
    extraGroups = [ "wheel" "devops" ];
    openssh.authorizedKeys.keys = [ "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMx2FC01/IaD/NxAmmz01/uyaSWMvI+Sy0EGP9JpS40TAAAABHNzaDo= kazeshini-31-07-2022)-yubikey1" ];
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
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  services.fstrim.enable = true;
  virtualisation.oci-containers.backend = "podman";
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  fileSystems."/home/apinter/Crate" = {
      device = "172.168.1.3:/shirayuki/Crate-data";
      fsType = "nfs";
  };

  services.openssh.enable = true;
  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11";
}
