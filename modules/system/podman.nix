{ config, pkgs, callPackage, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        flags = [ 
          "--all"
          "--force"
          "--volumes"
        ];
      };
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
    oci-containers.backend = "podman";
  };
}
