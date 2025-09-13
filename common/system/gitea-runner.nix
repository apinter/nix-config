{ config, pkgs, lib, ... }:

{

systemd.services.gitea-runner = {
    enable = true;
    description = "Gitea-runner-pod";
    after = [ "network-online.target" "basic.target" ];
    environment = {
        LANG = "en_US.UTF-8";
    };
    path = [ 
        "/run/wrappers"
        pkgs.docker
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
        "-${pkgs.podman}/bin/podman kube down /home/apinter/kube/gitea-runner.yml"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play --authfile=/home/apinter/.secret/auth.json /home/apinter/kube/gitea-runner.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/gitea-runner.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
  };
}
