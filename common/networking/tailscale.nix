{ config, pkgs, callPackage, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  # extraSetFlags = [ ## In case dns resolution is not working
  #   "--accept-dns=false"
  #   ];
  };
  services.resolved.enable = true;
  networking.search = [ "mining-octatonic.ts.net" ];
}
