{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./monitoring.nix
      ./autoupgrade.nix
      ./garbagecollect.nix
      ./containers.nix
      ./systemd.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  security.rtkit.enable = true;
  zramSwap.enable = true;
  networking.hostName = "busybee";
  networking.networkmanager.enable = true;
  networking.hostId = "681ebfdc";

  time.timeZone = "Asia/Jakarta";

  users.users.apinter = {
    isNormalUser = true;
    linger = true;
    home = "/home/apinter";
    description = "Attila Pinter";
    extraGroups = [ "wheel" "devops" "podman" "docker"];
    openssh.authorizedKeys.keys = [ 
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINYgL/PMWtjixH8gzkXuuU03GcgdXFNXfX42HuFGGoHGAAAABHNzaDo= tw.kazeshini-30-03-2024-adathor-yubikeyA" 
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIEGr9vLSNBrHSY2RwFHpkXWSCGPtvRqxgVLKduww+1FAAAAABHNzaDo= tw.kazeshini-30-03-2024-adathor-yubikeyC" 
    ];
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
    git
    ## <podman rootless requirements>
    conmon
    crun
    slirp4netns
    su
    ## </podman rootless requirements>
    dive
    podman-tui
    glances
    python3
    python312Packages.pip
    python312Packages.docker
    python312Packages.pyyaml
  ];

  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  virtualisation.docker.enable = true;

  services.fstrim.enable = true;
  virtualisation.oci-containers.backend = "podman";
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.logind.lidSwitch = "ignore";
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  fileSystems."/data/Crate" = {
      device = "172.168.1.3:/shirayuki/Crate-data";
      fsType = "nfs";
      options = [
        "timeo=600"
      ];
  };

  fileSystems."/data/Aurora" = {
      device = "172.168.1.3:/shirayuki/Aurora";
      fsType = "nfs";
      options = [
        "timeo=600"
      ];
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
