{ config, pkgs, callPackage, ... }:

{

services.xserver.enable = true;
services.xserver.displayManager.sddm.wayland.enable = true;
services.xserver.desktopManager.plasma6.enable = true;
services.xserver.displayManager.defaultSession = "plasmawayland";

qt = {
  enable = true;
  platformTheme = "gnome";
  style = "adwaita-dark";
};
}