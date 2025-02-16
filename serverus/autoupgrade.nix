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
          ExecStart = "${pkgs.systemd}/bin/systemctl --user restart uptime fileshare wallabag";
          RemainAfterExit = false;
      };
  };

  systemd.timers.update-rootfull-containers = {
        enable = true;
        description = "Enable automatic update of rootfull containers";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
  };

  systemd.services.update-rootfull-containers = {
      description = "Restart rootfull containers for updating them";
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
          ExecStart = "${pkgs.systemd}/bin/systemctl restart traefik coturn pihole";
          RemainAfterExit = false;
      };
  };

  systemd.user.services.update-rootless-containers = {
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
          ExecStart = "${pkgs.systemd}/bin/systemctl --user restart uptime fileshare wallabag searxng";
          RemainAfterExit = false;
      };
  };
}
