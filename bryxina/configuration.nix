{ config, pkgs, callPackage, modulesPath, ... }:

{
  imports =
    [
      ../modules/systemd-user/flatpak-auto-update.nix
      ../modules/system/gitea-runner.nix
      ../modules/monitoring/node-exporter.nix
      ../modules/hardware/accel.nix
      ../modules/system/garbagecollect.nix
      ../modules/system/autoupgrade.nix
      # ../modules/DE/plasma6.nix
      # ../modules/DE/sway.nix
      ../modules/DE/hyprland.nix
      ../modules/hardware/fwupd.nix
      ../modules/system/journald.nix
      ../modules/networking/ssh.nix
      ../modules/system/locales.nix
      ../modules/users/adathor.nix
      ../modules/users/bryxina.nix
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
      ../modules/hardware/bluetooth.nix
      ../modules/system/nix_cfg.nix
      ../modules/system/flatpak_portals.nix
      ../modules/system/plymouth.nix
      ../modules/networking/tailscale.nix
      ./hardware-configuration.nix
      # ./containers.nix
    ];

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "bryxina";
  
  fileSystems."/home/bryxina/Reno" = {
      device = "172.168.1.3:/shirayuki/Home/skye";
      fsType = "nfs";
  };

  services.borgbackup.jobs.main = {
    paths = "/home/bryxina";
    encryption.mode = "none";
    repo = "/home/bryxina/Reno/BorgBackup";
    compression = "auto,zstd";
    startAt = "daily";
    exclude = [ "/home/bryxina/Reno" ];
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

  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  system.stateVersion = "23.05"; 
}
