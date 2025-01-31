{ config, pkgs, callPackage, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/system/autoupgrade.nix
      ../common/system/garbagecollect.nix
      ../common/hardware/accel.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  networking.hostName = "otong";
  networking.networkmanager.enable = true;
  zramSwap.enable = true;
  time.timeZone = "Asia/Jakarta";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services.flatpak.enable = true;

  users.users.apinter = {
    isNormalUser = true;
    home = "/home/apinter";
    initialPassword = "pw123";
    description = "Attila Pinter";
    extraGroups = [ "wheel" "devops" "docker" "scanner" "lp" ];
    openssh.authorizedKeys.keys = [ 
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINYgL/PMWtjixH8gzkXuuU03GcgdXFNXfX42HuFGGoHGAAAABHNzaDo= tw.kazeshini-30-03-2024-adathor-yubikeyA" 
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIEGr9vLSNBrHSY2RwFHpkXWSCGPtvRqxgVLKduww+1FAAAAABHNzaDo= tw.kazeshini-30-03-2024-adathor-yubikeyC" 
      ];
  };

  users.groups.devops.gid = 5000;
  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
  users.users.apinter.shell = pkgs.fish;

  security.sudo.extraRules = [
    {
      groups = [ "devops" ];
      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.light.enable = true;
  zramSwap.enable = true;
  programs.sway.extraSessionCommands = ''
    export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
    export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
    eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh);
    export SSH_AUTH_SOCK;
  '';

  virtualisation ={
    podman = { 
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  virtualisation.oci-containers.backend = "podman";
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  services.fstrim.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
  
  services.openssh.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPortRanges =  [ ];
    allowedUDPPorts = [  ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
