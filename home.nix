{ config, pkgs, lib, ... }:

{
  home.username = "apinter";
  home.homeDirectory = "/home/apinter";
  home.stateVersion = "23.11";
  
  home.packages = [
    pkgs.hello
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
