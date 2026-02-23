{ config, pkgs, callPackage, meta, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/monitoring/node-exporter.nix
      ../modules/systemd-user/flatpak-auto-update.nix
      ../modules/hardware/accel.nix
      ../modules/system/garbagecollect.nix
      ../modules/system/autoupgrade.nix
      ../modules/system/printer.nix
      ../modules/DE/gnome.nix
      ../modules/DE/hyprland.nix
      ../modules/system/fonts.nix
      ../modules/hardware/fwupd.nix
      ../modules/networking/ssh.nix
      ../modules/system/locales.nix
      ../modules/users/adathor.nix
      ../modules/users/podman.nix
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
      ../modules/system/avahi.nix
      ../modules/system/libvirt.nix
      ../modules/system/cockpit.nix
    ];

  networking.hostName = "kazeshini";

  nix.settings.trusted-users = [ "root" meta.username ];

  fileSystems."/home/apinter/Steam" = {
      device = "/dev/disk/by-label/SSData";
      fsType = "btrfs";
      options = [ "subvol=Steam" "compress=zstd:1" ];
  };

  fileSystems."/home/apinter/Storage" = {
      device = "/dev/disk/by-label/Stora0";
      fsType = "btrfs";
      options = [ "subvol=Stora" "compress=zstd:1" ];
  };

  fileSystems."/home/apinter/Backup" = {
      device = "172.168.1.3:/shirayuki/Home/apinter";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
  };

  services.udev.packages = [ 
    pkgs.yubikey-personalization
    pkgs.qmk
    pkgs.qmk-udev-rules 
    pkgs.qmk_hid
    pkgs.via
    pkgs.vial
  ];
  environment.systemPackages = with pkgs; [ via ];
  hardware.keyboard.qmk.enable = true;
  services.pcscd.enable = true;
  programs.fish.enable = true;
  users.users.apinter.shell = pkgs.fish;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.xserver = {                                                       
    enable = true;                                                          
    xkb.options = "caps:swapescape";
  };                                                                           

  services.borgbackup.jobs.main = {
    startAt = "*-*-* 11:00:00";
    paths = [
      "/.snapshots/HOME-SNAPSHOT"
    ];
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/.secrets/borg_keyfile";
    };
    repo = "/home/apinter/Backup/backup-kazeshini-apinter-nix";
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

  system.stateVersion = "25.05";
  hardware.steam-hardware.enable = true;
}
