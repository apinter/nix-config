{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../modules/monitoring/node-exporter.nix
      ../modules/system/garbagecollect.nix
      ../modules/DE/server_packages.nix
      ../modules/hardware/fwupd.nix
      ../modules/networking/ssh.nix
      ../modules/system/locales.nix
      ../modules/users/adathor.nix
      ../modules/networking/network_manager.nix
      ../modules/system/btrfs.nix
      ../modules/system/docker.nix
      ../modules/system/podman.nix
      ../modules/system/pipewire.nix
      ../modules/system/systemd-boot.nix
      ../modules/system/zram.nix
      ../modules/system/rtkit.nix
      ../modules/networking/fw_off.nix
      ../modules/networking/tailscale.nix
      ../modules/system/nix_cfg.nix
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

  nixpkgs.overlays = [
    (final: prev: {
      go_1_25_3 = prev.go_1_25.overrideAttrs (finalAttrs: prevAttrs: {
        version = "1.25.3";
        src = final.fetchurl {
          url = "https://go.dev/dl/go${finalAttrs.version}.src.tar.gz";
          hash = "sha256-qBpLpZPQAV4QxR4mfeP/B8eskU38oDfZUX0ClRcJd5U=";
        };
      });
      buildGo1253Module = prev.buildGoModule.override {
        go = final.go_1_25_3;
      };
      cosign = prev.cosign.override {
        buildGoModule = final.buildGo1253Module;
      };
    })
  ];
  
  fileSystems."/data/Crate" = {
      device = "172.168.1.3:/shirayuki/Crate-data";
      fsType = "nfs";
      options = [
        "timeo=600"
      ];
  };

  fileSystems."/data/Immich" = {
      device = "172.168.1.3:/shirayuki/immich";
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
    paths = "/.snapshots/HOME-SNAPSHOT";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/.secrets/borg_keyfile";
    };
    repo = "/data/Backup";
    compression = "auto,zstd";
    inhibitsSleep = true;
    persistentTimer = true;
    readWritePaths = [
      "/.snapshots"
    ];
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

    preHook = ''
      if [ ! -d "/.snapshots" ]; then
        ${pkgs.btrfs-progs}/bin/btrfs subvolume create /.snapshots
      fi

      if [ -d "/.snapshots/HOME-SNAPSHOT" ]; then
        ${pkgs.btrfs-progs}/bin/btrfs subvolume delete /.snapshots/HOME-SNAPSHOT
      fi

      ${pkgs.btrfs-progs}/bin/btrfs subvolume snapshot -r /home /.snapshots/HOME-SNAPSHOT
    '';

    postHook = ''
      source /opt/mtx/mtx.env

        if [ "$exitStatus" -eq 0 ]; then
          borg_status_msg="✅ Success"
        else
          borg_status_msg="❌ Failed"
        fi

      ${pkgs.btrfs-progs}/bin/btrfs subvolume delete /.snapshots/HOME-SNAPSHOT
      ${pkgs.curl}/bin/curl -X PUT "https://matrix.adathor.com/_matrix/client/r0/rooms/$MY_MTX_ROOMID/send/m.room.message/$(date +%s)?access_token=$MY_MTX_TOKEN" -H "Content-Type: application/json" --data "{\"msgtype\":\"m.text\",\"body\":\"$HOSTNAME backup status is: $borg_status_msg \"}"
    '';
  };

  services.prometheus.exporters.systemd.enable = true;

  system.stateVersion = "23.11";
}
