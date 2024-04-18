{ config, pkgs, lib, ... }:

{
  home.username = "apinter";
  home.homeDirectory = "/home/apinter";
  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
nix-shell '<home-manager>' -A install
