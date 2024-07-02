{ config, pkgs, lib, ... }:

{
systemd.user.services.uptime = {
    enable = true;
    description = "uptime-pod";
    after = [ "network-online.target" "basic.target" "data-Aurora.mount" ];
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm uptime-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/louislam/uptime-kuma:1"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/uptime.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/uptime.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.services.traefik = {
    enable = true;
    description = "traefik-pod";
    after = [ "network-online.target" "basic.target" ];
    environment = {
        HOME = "/root";
        LANG = "en_US.UTF-8";
        USER = "root";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm traefik-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/traefik:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/traefik.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/traefik.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};


systemd.services.coturn = {
    enable = true;
    description = "coturn-pod";
    after = [ "network-online.target" "basic.target" ];
    environment = {
        HOME = "/root";
        LANG = "en_US.UTF-8";
        USER = "root";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm coturn-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json registry.adathor.com/crate/coturn:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/coturn.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/coturn.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.services.pihole = {
    enable = true;
    description = "pihole-pod";
    after = [ "network-online.target" "basic.target" ];
    environment = {
        HOME = "/root";
        LANG = "en_US.UTF-8";
        USER = "root";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm pihole-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/pihole/pihole:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/pihole.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/pihole.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.fileshare= {
    enable = true;
    description = "file-serve-pod";
    after = [ "network-online.target" "basic.target" "data-Aurora.mount" ];
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
        ppodkgs.slirp4netns
        pkgs.su
        pkgs.shadow
        pkgs.fuse-overlayfs
        config.virtualisation.podman.package
    ];
    unitConfig = {
    };
    serviceConfig = {
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm file-serve"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json registry.adathor.com/devops/file-serve:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/file-serve.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/file-serve.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.wallabag= {
    enable = true;
    description = "wallabag-pod";
    after = [ "network-online.target" "basic.target" "data-Aurora.mount" ];
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm wallabag"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/redis"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/wallabag/wallabag"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/wallabag.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/wallabag.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};
}
