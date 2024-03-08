# { config, pkgs, callPackage, ... }:

# {
#   xdg.portal.enable = true;
#   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

#   services.xserver = {
#     enable = true;
#     desktopManager = {
#       xterm.enable = false;
#       xfce.enable = true;
#     };
#     displayManager.defaultSession = "xfce";
#   };   

# environment.systemPackages = with pkgs; [
#     albert
#     xorg.xhost
#     xfce.xfce4-whiskermenu-plugin
#     xfce.thunar-archive-plugin
#     xfce.xfce4-volumed-pulse
#     xfce.xfce4-pulseaudio-plugin
#     xfce.xfce4-timer-plugin
#     xfce.xfce4-notes-plugin
#   ];
# }