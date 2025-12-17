{ config, pkgs, callPackage, ... }:

{
  imports =
    [
      ../modules/monitoring/node-exporter.nix
      ../modules/systemd-user/flatpak-auto-update.nix
      ../modules/hardware/accel.nix
      ../modules/system/gitea-runner.nix
      ../modules/system/garbagecollect.nix
      ../modules/system/autoupgrade.nix
      ../modules/DE/plasma6.nix
      ../modules/system/printer.nix
      ../modules/hardware/fwupd.nix
      ../modules/system/journald.nix
      ../modules/networking/ssh.nix
      ../modules/system/locales.nix
      ../modules/users/sofie.nix
      ../modules/users/adathor.nix
      ../modules/networking/network_manager.nix
      ../modules/system/btrfs.nix
      ../modules/system/docker.nix
      ../modules/system/podman.nix
      ../modules/system/kernel.nix
      ../modules/system/pipewire.nix
      ../modules/system/systemd-boot.nix
      ../modules/system/zram.nix
      ../modules/system/rtkit.nix
      ../modules/networking/fw_off.nix
      ../modules/networking/tailscale.nix
      ../modules/hardware/bluetooth.nix
      ../modules/system/nix_cfg.nix
      ../modules/system/flatpak_portals.nix
      ../modules/system/plymouth.nix
      ./containers.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "sofie";

  fileSystems."/home/sofie/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/sofie";
      fsType = "nfs";
  };

  fileSystems."/home/sofie/VMs" = {
      device = "/dev/disk/by-uuid/4cca616f-6396-4baa-9370-a2b345b9c57c";
      fsType = "btrfs";
      options = [ "compress=zstd:1" ];
  };

  environment.systemPackages = with pkgs; [
    pkgs.sane-backends
    pkgs.gutenprint
    pkgs.brlaser
    pkgs.brscan5
    pkgs.brscan4
  ];

  services.borgbackup.jobs.main = {
    paths = [
      "/home"
      "/var/lib/containers/storage/volumes"
    ];
    encryption.mode = "none";
    repo = "/home/sofie/Reno/BorgBackup";
    compression = "auto,zstd";
    startAt = "daily";
    exclude = [ 
      "/home/sofie/Reno"
      "/home/sofie/VMs"
    ];
    inhibitsSleep = true;
    persistentTimer = true;
    extraCreateArgs = [
      "--progress"
      "--stats"
    ];
    prune.keep = {
      daily = 2;
      weekly = 4;
      monthly = -1;
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

  system.stateVersion = "23.05";
}
