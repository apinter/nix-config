{ config, pkgs, callPackage, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  services = {

      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };

      desktopManager = {
        plasma6.enable = true;
      };

      displayManager = {
        sddm.enable = true;
        sddm.wayland.enable = true;
        defaultSession = "plasma";
      };

      gnome = {
        gnome-keyring.enable = true;
      };
  };

  security = {
    pam = {
      services = {
        sddm.enableGnomeKeyring = true;
      };  
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.ark
    zip
    unzip
    bash
    vim
    wget
    curl
    ranger
    git
    firefox
    python3
    distrobox
    xorg.xhost
    conmon
    crun
    slirp4netns
    su
    mesa
    mesa-demos 
    wineWowPackages.stable
    winetricks
    gnome-disk-utility
    gnome-keyring
    kdePackages.kdeconnect-kde
    kdePackages.print-manager
    pkgs.github-desktop
  ];
}
