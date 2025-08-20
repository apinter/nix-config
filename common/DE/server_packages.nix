{ config, pkgs, callPackage, ... }:

{

  environment.systemPackages = with pkgs; [
    vim 
    curl
    htop
    git
    ## <podman rootless requirements>
    conmon
    crun
    slirp4netns
    su
    ## </podman rootless requirements>
    dive
    podman-tui
    glances
    python3
    python312Packages.pip
    python312Packages.docker
    python312Packages.pyyaml
    cifs-utils
    nfs-utils
    neovim
    nebula
    cosign
  ];
}
