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

systemd.user.services.crate = {
    enable = true;
    description = "Crate";
    after = [ "network-online.target" "basic.target" ];
    environment = {
        HOME = "/home/apinter";
        LANG = "en_US.UTF-8";
        USER = "apinter";
    };
    path = [ 
        "/run/wrappers"
        pkgs.podman
        pkgs.bash
        pkgs.conmon
        pkgs.crun
        pkgs.slirp4netns
        pkgs.su
        pkgs.shadow
        pkgs.fuse-overlayfs
        config.virtualisation.podman.package
    ];
    unitConfig = {
    };
    serviceConfig = {
        Type = "oneshot";
        TimeoutStartSec = 900;
        ExecStart = "${pkgs.bash}/bin/bash /home/apinter/bin/crate_pod.sh";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.jellyfin = {
    enable = true;
    description = "Jellyfin-pod";
    after = [ "network-online.target" "basic.target" ];
    environment = {
        HOME = "/home/apinter";
        LANG = "en_US.UTF-8";
        USER = "apinter";
    };
    path = [ 
        "/run/wrappers"
        pkgs.podman
        pkgs.bash
        pkgs.conmon
        pkgs.crun
        pkgs.slirp4netns
        pkgs.su
        pkgs.shadow
        pkgs.fuse-overlayfs
        config.virtualisation.podman.package
    ];
    unitConfig = {
    };
    serviceConfig = {
        Type = "oneshot";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm jellyfin-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/jellyfin/jellyfin:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/jellyfin.yml";
        ExecStop = "${pkgs.podman}/bin/podman pod stop jellyfin-pod";
        ExecStopPost = "${pkgs.podman}/bin/podman pod rm jellyfin-pod";
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
        ExecStart = "/data/nebula/nebula -config /data/nebula/config.yml";
        Restart = "always";
        RestartSec = "5";
        };
    };
}
