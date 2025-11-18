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
    noto-fonts
    liberation_ttf
    hack-font
    google-fonts
    roboto
    roboto-mono
    noto-fonts
    ubuntu-sans
    ubuntu-classic
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
