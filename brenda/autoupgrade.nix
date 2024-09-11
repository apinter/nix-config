{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "03.15";
    persistent = true;
    flake = "github:apinter/nix-config";
    flags = [ 
      "--no-write-lock-file"
      ];
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
    allowReboot = true;
    randomizedDelaySec = "15min";
  };

  systemd.timers.update-rootful-containers = {
        enable = true;
        description = "Enable automatic update of rootfull containers";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
  };

  systemd.services.update-rootful-containers = {
      description = "Restart rootful containers for updating them";
      after = [ "network-online.target" "basic.target" ];
      environment = {
          HOME = "/root";
          LANG = "en_US.UTF-8";
          USER = "root";
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
          ExecStart = "${pkgs.systemd}/bin/systemctl restart pihole";
          RemainAfterExit = false;
      };
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
          ExecStart = "${pkgs.systemd}/bin/systemctl --user restart unifi transmission";
          RemainAfterExit = false;
      };
  };
}
