{ config, pkgs, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    desktopManager = {
      xterm.enable = false;
      plasma6.enable = true;
      xfce.enable = false;
    };
    displayManager = { 
      defaultSession = "plasma";
      sddm.theme = "breeze";
      sddm.wayland.enable = true;
      sddm.package = pkgs.kdePackages.sddm;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  };
}
