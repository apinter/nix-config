{ config, pkgs, lib, ... }:

{
  home.username = "apinter";
  home.homeDirectory = "/home/apinter";

  home.stateVersion = "23.11";

  home.packages = [
    pkgs.ranger
    pkgs.kubectl
    pkgs.kitty
  ];

  home.file.".config/fish/config.fish".source= ./dotconf/fish/config.fish; 
  home.file.".config/sway/config".source= ./dotconf/sway/sway/config;
  home.file.".config/sway/config.d/40-inputs.conf".source= ./dotconf/sway/sway/config.d/40-inputs.conf;
  home.file.".config/sway/config.d/50-openSUSE.conf".source= ./dotconf/sway/sway/config.d/50-openSUSE.conf;
  home.file.".config/waybar/config".source= ./dotconf/sway/waybar/config;
  home.file.".config/waybar/style.css".source= ./dotconf/sway/waybar/style.css;
  home.file.".config/mako/config".source= ./dotconf/sway/mako/config;
  home.file.".config/wofi/config".source= ./dotconf/sway/wofi/config;
  home.file.".config/wofi/style.css".source= ./dotconf/sway/wofi/style.css;
  home.file.".config/kitty/current-theme.conf".source= lib.mkDefault ./dotconf/kitty/current-theme.conf;
  home.file.".config/kitty/kitty.conf".source= lib.mkDefault ./dotconf/kitty/kitty.conf;
  home.file.".gitconfig".source = ./dotconf/.gitconfig;

  programs.home-manager.enable = true;
  programs.broot.enable = true;
  programs.bat.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
  };
}

