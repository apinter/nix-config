{ config, pkgs, callPackage, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
      };
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  virtualisation.oci-containers.backend = "podman";
}
