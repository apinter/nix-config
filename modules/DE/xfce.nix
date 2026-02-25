{ config, pkgs, callPackage, ... }:

{
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.defaultSession = "xfce";
  };   

  environment.systemPackages = with pkgs; [
      xorg.xhost
      xfce.xfce4-whiskermenu-plugin
      xfce.thunar-archive-plugin
      xfce.xfce4-volumed-pulse
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-timer-plugin
      xfce.xfce4-notes-plugin
    ];
}
