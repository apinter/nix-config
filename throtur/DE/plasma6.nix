{ config, pkgs, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "breeze";
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # environment.systemPackages = with pkgs; [
  # ];
}