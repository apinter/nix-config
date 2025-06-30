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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStart = "${pkgs.bash}/bin/bash /home/apinter/bin/crate_pod.sh";
        Restart = "always";
        RestartSec=15;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.jellyfin = {
    enable = true;
    description = "Jellyfin-pod";
    after = [ "network-online.target" "basic.target" "data-Aurora.mount" ];
    requires = [ "data-Aurora.mount" ];
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
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/jellyfin/jellyfin:latest"
        "-${pkgs.podman}/bin/podman pod rm jellyfin-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/jellyfin.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/jellyfin.yml";
        Restart = "always";
        RestartSec=5;
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json registry.adathor.com/devops/homepage:latest"
        "-${pkgs.podman}/bin/podman pod rm homepage-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/homepage.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/homepage.yml";
        Restart = "always";
        RestartSec=5;
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json quay.io/recordsansible/ara-api:latest"
        "-${pkgs.podman}/bin/podman pod rm ara-api-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/ara.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/ara.yml";
        Restart = "always";
        RestartSec=5;
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres:13.4-alpine"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json quay.io/hedgedoc/hedgedoc:1.9.9-alpine"
        "-${pkgs.podman}/bin/podman pod rm hedgedoc"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/hedgedoc.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/hedgedoc.yml";
        Restart = "always";
        RestartSec=5;
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/matrixdotorg/synapse:latest"
        "-${pkgs.podman}/bin/podman pod rm parallel-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/parallel.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/parallel.yml";
        Restart = "always";
        RestartSec=5;
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/matrixdotorg/synapse:latest"
        "-${pkgs.podman}/bin/podman pod rm monitoring"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/monitoring.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/monitoring.yml";
        Restart = "always";
        RestartSec=5;
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres:14"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/gitea/gitea:latest-rootless"
        "-${pkgs.podman}/bin/podman pod rm gitea"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/gitea.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/gitea.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.ittools = {
    enable = true;
    description = "it-tools-pod";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/corentinth/it-tools:latest"
        "-${pkgs.podman}/bin/podman pod rm it-tools-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/it-tools.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/it-tools.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};


systemd.user.services.shopping = {
    enable = true;
    description = "shopping-list-pod";
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
        Type = "simple";
        TimeoutStartSec = 120;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/adathor/shopping-bot:latest"
        "-${pkgs.podman}/bin/podman pod rm shopping-list"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/shopping.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/shopping.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.atuin-syncer = {
    enable = true;
    description = "atuin-sync-pod";
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
        Type = "simple";
        TimeoutStartSec = 120;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres:14"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json ghcr.io/atuinsh/atuin:latest"
        "-${pkgs.podman}/bin/podman pod rm atuin-sync"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/atuin-sync.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/atuin-sync.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.authentik-svc = {
    enable = true;
    description = "authentik-svc-pod";
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
        Type = "simple";
        TimeoutStartSec = 120;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth2.json docker.io/library/postgres:16-alpine"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth2.json docker.io/library/redis:alpine"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth2.json ghcr.io/goauthentik/server:2024.10.5"
        "-${pkgs.podman}/bin/podman pod rm authentik-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/authentik.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/authentik.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.fileshare= {
    enable = true;
    description = "file-serve-pod";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json registry.adathor.com/devops/file-serve:latest"
        "-${pkgs.podman}/bin/podman pod rm file-serve"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/file-serve.yml";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/redis"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/wallabag/wallabag"
        "-${pkgs.podman}/bin/podman pod rm wallabag"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/wallabag.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/wallabag.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.searxng= {
    enable = true;
    description = "searxng-pod";
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
        Type = "simple";
        TimeoutStartSec = 900;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/searxng/searxng:latest"
        "-${pkgs.podman}/bin/podman pod rm searxng-pod"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/searxng.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/searxng.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};

systemd.user.services.mealie-app = {
    enable = true;
    description = "Mealie pod";
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
        Type = "simple";
        TimeoutStartSec = 120;
        ExecStartPre = lib.mkBefore [
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/library/postgres:15"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json ghcr.io/mealie-recipes/mealie:latest"
        "-${pkgs.podman}/bin/podman pod rm mealie"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/mealie.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/mealie.yml";
        Restart = "always";
        RestartSec=5;
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
};
}
