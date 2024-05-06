{ config, pkgs, lib, ... }:

{
systemd.user.services.crate = {
    enable = true;
    description = "Crate";
    after = [ "network-online.target" "basic.target" "data-Crate.mount" ];
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
        Type = "oneshot";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm jellyfin-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/jellyfin/jellyfin:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/jellyfin.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/jellyfin.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.homepage = {
    enable = true;
    description = "homepage-pod";
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
        Type = "oneshot";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pod rm homepage-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json registry.adathor.com/devops/homepage:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/homepage.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/homepage.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.ara = {
    enable = true;
    description = "ara-pod";
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
        "-${pkgs.podman}/bin/podman pod rm ara-api-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json quay.io/recordsansible/ara-api:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/ara.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/ara.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.hedgedoc = {
    enable = true;
    description = "hedgedoc-pod";
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
        "-${pkgs.podman}/bin/podman pod rm hedgedoc"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres:13.4-alpine"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json quay.io/hedgedoc/hedgedoc:1.9.9-alpine"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/hedgedoc.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/hedgedoc.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.parallel = {
    enable = true;
    description = "parallel-pod";
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
        "-${pkgs.podman}/bin/podman pod rm parallel-pod"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/matrixdotorg/synapse:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/parallel.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/parallel.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.monitoring = {
    enable = true;
    description = "monitoring-pod";
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
        "-${pkgs.podman}/bin/podman pod rm monitoring"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/matrixdotorg/synapse:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/monitoring.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/monitoring.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.gitea = {
    enable = true;
    description = "gitea-pod";
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
        "-${pkgs.podman}/bin/podman pod rm gitea"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres:14"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/gitea/gitea:latest-rootless"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/gitea.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/gitea.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

}
