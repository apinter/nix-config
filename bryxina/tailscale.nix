{ config, pkgs, callPackage, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  # extraSetFlags = [ ## In case dns resolution is not working
  #   "--accept-dns=false"
  #   ];
  };
  services.resolved.enable = true;
  networking.search = [ "mining-octatonic.ts.net" ];
}
