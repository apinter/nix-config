{ config, pkgs, callPackage, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.flags = [ "--volumes" "--force"  "--all"];
  virtualisation.docker.autoPrune.dates = "daily";
}
