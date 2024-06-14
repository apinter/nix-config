{ modulesPath, config, lib, pkgs, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      #./hardware-configuration.nix
      ./monitoring.nix
      ./autoupgrade.nix
      ./garbagecollect.nix
      ./disk-config.nix
      # ./containers.nix
      # ./systemd.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial
  '';
  zramSwap.enable = true;
  networking.hostName = "serverus";
  networking.networkmanager.enable = true;
  networking.hostId = "ffc4c072";

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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYvFTHcwLuF8romP+YYXiWBUk2r32AlK0HvQMu4nyAd root@medusa"
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

  virtualisation.oci-containers.backend = "podman";
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
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
