{ config, pkgs, lib, ... }:

{
  home.username = "apinter";
  home.homeDirectory = "/home/apinter";

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
