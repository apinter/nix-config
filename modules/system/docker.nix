{ config, pkgs, callPackage, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ 
        "--volumes"
        "--force"
        "--all"
      ];
      dates = "daily";
    };
  };
}
