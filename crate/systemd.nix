{ config, pkgs, lib, ... }:

{
systemd.user.services.crate-cron = {
    enable = true;
    description = "Crate cron.php job";
    unitConfig = {
        };
        serviceConfig = {
            Type = "oneshot";
            ExecCondition = "${pkgs.podman}/bin/podman exec -it --user www-data crate-app php -f occ status -e";
            ExecStart = "${pkgs.podman}/bin/podman exec -it --user www-data crate-app php -f cron.php";
        };
};

systemd.user.timers.crate-cron = {
    enable = true;
    description = "Run Crate cron.php every 5 minutes";
    timerConfig = {
        OnBootSec = "5min";
        OnUnitActiveSec = "5min";
        Persistent = "true";
    };
    wantedBy = [ "timers.target" ];
};

systemd.user.services.crate = {
    enable = true;
    description = "Crate";
    after = [ "network-online.target" "basic.target" ];
    path = [ 
        pkgs.podman
        pkgs.bash
        ];
    unitConfig = {
    };
    serviceConfig = {
        Type = "oneshot";
        TimeoutStartSec = 900;
        ExecStart = "${pkgs.bash}/bin/bash /home/apinter/bin/crate_pod.sh";
        RemainAfterExit = false;
    };
    wantedBy = [ "default.target" ];
};

systemd.services.nebula = {
    enable = true;
    description = "Nebula VPN";
    after = [ "network-online.target" "basic.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
        SyslogIdentifier = "nebula";
        ExecStart = "/root/nebula -config /home/apinter/.secrets/config.yml";
        Restart = "always";
        RestartSec = "5";
        };
    };
}
