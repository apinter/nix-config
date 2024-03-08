{ config, pkgs, callPackage, ... }:

{

  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.sddm.theme = "breeze";
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.full
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.konsole
    kdePackages.konversation
    kdePackages.kwrited
    kdePackages.kalk
    kdePackages.kdeconnect-kde
    kdePackages.kdeplasma-addons
    kdePackages.okular
  ];

}