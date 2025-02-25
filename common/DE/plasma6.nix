{ config, pkgs, callPackage, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.desktopManager = {
      plasma6.enable = true;
  };

  services.displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      defaultSession = "plasma";
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
    microsoft-edge
    firefox
    python3
    distrobox
    xorg.xhost
    conmon
    crun
    slirp4netns
    su
    mesa
    glxinfo
    wineWowPackages.stable
    winetricks
    gnome-disk-utility
    gnome-keyring
    kdePackages.kdeconnect-kde
    pkgs.github-desktop
  ];

## gnome-keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
}
