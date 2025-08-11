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
  environment.systemPackages = [ gnome.adwaita-icon-theme ];
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];

  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab  {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
        };
      });
    })
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
