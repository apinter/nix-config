{ config, pkgs, pkgsFlatpak, callPackage, ... }:

{
  programs.dconf.enable = true;
  services.flatpak = {
    enable = true;
    package = pkgsFlatpak.flatpak;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
