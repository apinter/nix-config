{ config, pkgs, callPackage, ... }:

{
  fonts = {
    packages =  with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    liberation_ttf
    hack-font
    google-fonts
    roboto
    roboto-mono
    ubuntu-sans
    ubuntu-classic
    ];
  };
}
