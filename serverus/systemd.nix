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

systemd.services.nebula = {
    enable = true;
    description = "Nebula VPN";
    after = [ "network-online.target" "basic.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
        SyslogIdentifier = "nebula";
        ExecStart = "/data/nebula/nebula -config /data/nebula/config.yml";
        Restart = "always";
        RestartSec = "5";
        };
    };
}
