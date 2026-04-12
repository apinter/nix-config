{ config, pkgs, callPackage, ... }:

let
  pkgs_flatpak = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "719c0c76fdadab54edb5704bbf9b939570cabbfb";
    hash = "sha256-HdqLaB+u1cQEk9s95P4nWdHP+QAXFkXeAkMG+FdT9m8="; 
  }) { inherit (pkgs) system; };
in

{
  programs.dconf.enable = true;
  services.flatpak.enable = true;
  services.flatpak.package = pkgs_flatpak.flatpak; 
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
