{ config, pkgs, callPackage, ... }:

{
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };

    resolved = {
      enable = true;
    };

    networking = {
      search = [ "mining-octatonic.ts.net" ];
    };
  };
}
