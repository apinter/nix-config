{ config, pkgs, callPackage, ... }:

{
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

}