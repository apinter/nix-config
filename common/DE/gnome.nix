{ config, pkgs, callPackage, ... }:

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  }  

  services.udev = {
    enable = true;
    packages = [ pkgs.gnome-settings-daemon ];
  };

  services.sysprof.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
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
