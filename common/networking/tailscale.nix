{ config, pkgs, callPackage, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    ## leaving it due to build failure
    # package = pkgs.tailscale.overrideAttrs { doCheck = false; };

  # extraSetFlags = [ ## In case dns resolution is not working
  #   "--accept-dns=false"
  #   ];
  };
  services.resolved.enable = true;
  networking.search = [ "mining-octatonic.ts.net" ];
}
