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
            Restart = "on-failure";
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

systemd.services.harborw = {
    enable = true;
    description = "Run Harbor watchdog";
    environment = {
        HOME = "/home/apinter";
        LANG = "en_US.UTF-8";
        USER = "apinter";
    };
    path = [ 
        "/run/wrappers"
        pkgs.docker
        pkgs.bash
        pkgs.curl
    ];
    unitConfig = {
        };
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.bash}/bin/bash /opt/harbor_watch.sh ";
            Restart = "on-failure";
        };
};

systemd.timers.harborw = {
    enable = true;
    description = "Run Harbor watchdog script every 15 minutes";
    timerConfig = {
        OnBootSec = "5min";
        OnUnitActiveSec = "15min";
        Persistent = "true";
    };
    wantedBy = [ "timers.target" ];
};
}
