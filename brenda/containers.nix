{ config, pkgs, lib, ... }:

{
## Required if want to run PiHole
virtualisation.containers.containersConf.settings = { 
        network.dns_bind_port = 5353;
};

systemd.user.services.unifi = {
    enable = true;
    description = "unifi-pod";
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
        "-${pkgs.podman}/bin/podman pod rm unifi-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/mongo:7"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json lscr.io/linuxserver/unifi-network-application:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/unifi.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/unifi.yml";
        Restart = "always";
        RestartSec=5s;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.transmission = {
    enable = true;
    description = "transmission-pod";
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
        "-${pkgs.podman}/bin/podman pod rm transmission-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/pihole/pihole:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/transmission.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/transmission.yml";
        Restart = "always";
        RestartSec=5s;
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
        Type = "oneshot";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm pihole-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/pihole/pihole:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/pihole.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/pihole.yml";
        Restart = "always";
        RestartSec=5s;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

}