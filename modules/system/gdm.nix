{ config, pkgs, callPackage, ... }:

{
  services = {
    displayManager.gdm.enable = true;
  };  
}
