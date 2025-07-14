{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "02:15";
    persistent = true;
    flake = "github:apinter/nix-config";
    flags = [ 
      "--no-write-lock-file"
      ];
    rebootWindow = {
      lower = "02:00";
      upper = "04:00";
    };
    allowReboot = true;
    randomizedDelaySec = "15min";
  };

  systemd.user.timers.update-user-containers = {
        enable = true;
        description = "Enable automatic update of rootless containers";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
  };

  systemd.user.services.update-user-containers = {
      description = "Restart rootless containers for updating them";
      after = [ "network-online.target" "basic.target" ];
      environment = {
          HOME = "/home/apinter";
          LANG = "en_US.UTF-8";
          USER = "apinter";
      };
      path = [ 
          "/run/wrappers"
          pkgs.systemd
      ];
      unitConfig = {
      };
      serviceConfig = {
          Type = "oneshot";
          TimeoutStartSec = 900;
          ExecStart = "${pkgs.systemd}/bin/systemctl --user restart crate jellyfin homepage ara hedgedoc parallel monitoring gitea ittools shopping atuin-syncer authentik-svc mealie-app searxng wallabag fileshare";
          RemainAfterExit = false;
      };
  };

}
