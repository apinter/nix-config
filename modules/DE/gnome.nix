{ config, pkgs, callPackage, ... }:

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };  

  services.udev = {
    enable = true;
    packages = [ pkgs.gnome-settings-daemon ];
  };

  services.sysprof.enable = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    gnomeExtensions.appindicator
    gnome-backgrounds
    gnome-tweaks
    gnome-keyring
    distrobox
  ];

  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);
}
