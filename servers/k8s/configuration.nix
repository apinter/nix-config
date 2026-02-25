{ modulesPath, config, lib, pkgs, meta, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix
      ./disk-config.nix
      ../../modules/system/garbagecollect.nix
      ../../modules/DE/server_packages.nix
      ../../modules/system/journald.nix
      ../../modules/networking/ssh.nix
      ../../modules/system/locales.nix
      ../../modules/users/adathor.nix
      ../../modules/networking/tailscale.nix
      ../../modules/networking/network_manager.nix
      ../../modules/system/btrfs.nix
      ../../modules/system/docker.nix
      ../../modules/system/podman.nix
      ../../modules/system/pipewire.nix
      ../../modules/system/systemd-boot.nix
      ../../modules/system/zram.nix
      ../../modules/system/rtkit.nix
      ../../modules/networking/fw_off.nix
      ../../modules/system/nix_cfg.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "nfs" ];
  networking.hostName = meta.hostname;
  networking.hostId = "681ebfdc";

  environment.systemPackages = with pkgs; [
    pkgs.prometheus-systemd-exporter
    neovim
    k3s
    cifs-utils
    nfs-utils
  ];

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
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.logind.lidSwitch = "ignore";

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

  system.stateVersion = "23.11";
}
