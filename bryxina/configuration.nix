{ config, pkgs, callPackage, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./systemd-user/flatpak-auto-update.nix
      ./monitoring/node-exporter.nix
      ./hardware/accel.nix
      ./system/garbagecollect.nix
      ./system/autoupgrade.nix
      ./DE/plasma6.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/";
  networking.hostName = "bryxina";
  networking.networkmanager.enable = true;
  security.rtkit.enable = true;
  zramSwap.enable = true;
  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.bryxina = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp" ];
  };

  users.users.apinter = {
    isNormalUser = true;
    home = "/home/apinter";
    description = "Attila Pinter";
    extraGroups = [ "wheel" "devops" ];
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
    ark
    zip
    unzip
    albert
    bash
    vim
    wget
    curl
    ranger
    git
    firefox
    policycoreutils
    python3
    distrobox
    xorg.xhost
    gnome.gnome-keyring
    conmon
    crun
    slirp4netns
    su
    mesa
    glxinfo
    wineWowPackages.stable
    winetricks
    gnome.gnome-disk-utility
  ];

  hardware.opengl.enable = true; 
  hardware.opengl.extraPackages = [ pkgs.mesa.drivers ];
  hardware.opengl.driSupport32Bit = true;
  programs.dconf.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-backends ];

  services.flatpak.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  virtualisation.oci-containers.backend = "podman";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.printing.drivers = [ pkgs.gutenprint ];
  services.avahi.openFirewall = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  services.printing.browsing = true;
  services.printing.listenAddresses = [ "*:631" ];
  services.printing.allowFrom = [ "all" ];
  services.printing.defaultShared = true;
  networking.firewall.enable = false;

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  fileSystems."/home/bryxina/Common" = {
      device = "172.168.1.3:/shirayuki/Common";
      fsType = "nfs";
  };
  
  fileSystems."/home/bryxina/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/skye";
      fsType = "nfs";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 
  system.stateVersion = "23.05"; 
}