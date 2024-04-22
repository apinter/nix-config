{ config, pkgs, lib, ... }:

{

systemd.user.services.gitea-runner = {
    enable = true;
    description = "Gitea-runner-pod";
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
        "-${pkgs.podman}/bin/podman kube down /home/apinter/kube/gitea-runner.yml"
        "-${pkgs.podman}/bin/podman pull --authfile=/home/apinter/.secret/auth.json docker.io/gitea/act_runner:latest"
        ];
        ExecStart = "${pkgs.podman}/bin/podman kube play /home/apinter/kube/gitea-runner.yml";
        ExecStop = "${pkgs.podman}/bin/podman kube down /home/apinter/kube/gitea-runner.yml";
        RemainAfterExit = true;
    };
    wantedBy = [ "default.target" ];
  };
}