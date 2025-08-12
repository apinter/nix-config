{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../common/monitoring/node-exporter.nix
      ../common/system/garbagecollect.nix
      ../common/DE/server_packages.nix
      ../common/hardware/fwupd.nix
      ../common/system/journald.nix
      ../common/networking/ssh.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/networking/network_manager.nix
      ../common/system/btrfs.nix
      ../common/system/docker.nix
      ../common/system/podman.nix
      ../common/system/pipewire.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/rtkit.nix
      ../common/networking/fw_off.nix
      ../common/networking/tailscale.nix
      ../common/system/nix_cfg.nix
      ./hardware-configuration.nix
      ./autoupgrade.nix
      ./containers.nix
      ./systemd.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "busybee";
  networking.hostId = "681ebfdc";

  environment.systemPackages = with pkgs; [
    pkgs.prometheus-systemd-exporter
  ];
  
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.logind.lidSwitch = "ignore";
  
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
  
  fileSystems."/data/Backup" = {
      device = "172.168.1.3:/shirayuki/Borg/busybee";
      fsType = "nfs";
      options = [
        "timeo=600"
      ];
  };

  services.borgbackup.jobs.main = {
    startAt = "*-*-* 05:00:00";
    paths = "/home";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/.secrets/borg_keyfile";
    };
    repo = "/data/Backup";
    compression = "auto,zstd";
    inhibitsSleep = true;
    persistentTimer = true;
    extraCreateArgs = [
      "--progress"
      "--stats"
    ];
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 12;
      yearly = -1;
    };
    postHook = ''
      source /opt/mtx/mtx.env

        if [ "$exitStatus" -eq 0 ]; then
          borg_status_msg="✅ Success"
        else
          borg_status_msg="❌ Failed"
        fi

      ${pkgs.curl}/bin/curl -X PUT "https://matrix.adathor.com/_matrix/client/r0/rooms/$MY_MTX_ROOMID/send/m.room.message/$(date +%s)?access_token=$MY_MTX_TOKEN" -H "Content-Type: application/json" --data "{\"msgtype\":\"m.text\",\"body\":\"$HOSTNAME backup status is: $borg_status_msg \"}"
    '';
  };

  services.prometheus.exporters.systemd.enable = true;

  system.stateVersion = "23.11";
}
