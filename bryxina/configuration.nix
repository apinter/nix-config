{ config, pkgs, callPackage, modulesPath, ... }:

{
  imports =
    [
      ../common/systemd-user/flatpak-auto-update.nix
      ../common/system/gitea-runner.nix
      ../common/monitoring/node-exporter.nix
      ../common/hardware/accel.nix
      ../common/system/garbagecollect.nix
      ../common/system/autoupgrade.nix
      # ../common/DE/plasma6.nix
      ../common/DE/sway.nix
      ../common/DE/greetd.nix
      ../common/hardware/fwupd.nix
      ../common/system/journald.nix
      ../common/networking/ssh.nix
      ../common/system/locales.nix
      ../common/users/adathor.nix
      ../common/users/bryxina.nix
      ../common/networking/network_manager.nix
      ../common/system/btrfs.nix
      ../common/system/docker.nix
      ../common/system/podman.nix
      ../common/system/kernel.nix
      ../common/system/pipewire.nix
      ../common/system/systemd-boot.nix
      ../common/system/zram.nix
      ../common/system/rtkit.nix
      ../common/networking/fw_off.nix
      ../common/hardware/bluetooth.nix
      ../common/system/nix_cfg.nix
      ../common/system/flatpak_portals.nix
      ../common/networking/tailscale.nix
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
      daily = 7;
      weekly = 4;
      monthly = -1;
    };
    postHook = ''
      source /opt/mtx/mtx.env
      curl -X PUT "https://matrix.adathor.com/_matrix/client/r0/rooms/$MY_MTX_ROOMID/send/m.room.message/$(date +%s)?access_token=$MY_MTX_TOKEN" -H "Content-Type: application/json" --data "{\"msgtype\":\"m.text\",\"body\":\"Bryxina's backup status is: $exitStatus\"}"
    '';
  };

  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  system.stateVersion = "23.05"; 
}
