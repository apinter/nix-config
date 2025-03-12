{ modulesPath, config, lib, pkgs, meta, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix
      # ./autoupgrade.nix
      # ./systemd.nix
      ./disk-config.nix
      # ./mesh.nix
      ../common/system/garbagecollect.nix
      ../common/DE/server_packages.nix
      ../common/system/journald.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "nfs" ];
  security.rtkit.enable = true;
  zramSwap.enable = true;
  networking.hostName = meta.hostname;
  networking.networkmanager.enable = true;
  networking.hostId = "681ebfdc";

  time.timeZone = "Asia/Jakarta";

  environment.systemPackages = with pkgs; [
    pkgs.prometheus-systemd-exporter
    neovim
    k3s
    cifs-utils
    nfs-utils
  ];

  users.users.apinter = {
    isNormalUser = true;
    password = "pw123";
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

  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  virtualisation.docker.enable = true;

  system.activationScripts.createFooFile.text = ''
      install -m 0644 -o root -g root <(echo "INSTALL_K3S_VERSION=v1.31+k3s1") /etc/k3s.env
    '';

  services.k3s = {
    enable = true;
    role = "server";
    # tokenFile = /opt/k3s/token;
    token = "SuperSecretTemporaryTokenPlaceholderForInitAndNotUsedOrCommittedSorryMrHacker";
    environmentFile = "/etc/k3s.env";
    extraFlags = toString ([
	    "--write-kubeconfig-mode \"0644\""
	    "--cluster-init"
	    "--disable servicelb"
	    "--disable traefik"
    ] ++ (if meta.hostname == "k8s00" then [] else [
	      "--server https://k8s00:6443"
    ]));
    clusterInit = (meta.hostname == "k8s00");
  };

  networking.extraHosts = ''
    172.168.255.22 k8s00
    172.168.255.24 k8s01
    172.168.255.23 k8s02
  '';

  services.rpcbind.enable = true;
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

  # fileSystems."/data/Crate" = {
  #     device = "172.168.1.3:/shirayuki/Crate-data";
  #     fsType = "nfs";
  #     options = [
  #       "timeo=600"
  #     ];
  # };

  # fileSystems."/data/Aurora" = {
  #     device = "172.168.1.3:/shirayuki/Aurora";
  #     fsType = "nfs";
  #     options = [
  #       "timeo=600"
  #     ];
  # };
  # services.prometheus.exporters.systemd.enable = true;

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
