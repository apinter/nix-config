{ config, pkgs, callPackage, ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPortRanges =  [ ];
    allowedUDPPorts = [  ];
  };
}
