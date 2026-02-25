{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "02:15";
    persistent = true;
    flake = "github:apinter/nix-config";
    flags = [ 
      "--no-write-lock-file"
      ];
    rebootWindow = {
      lower = "02:00";
      upper = "04:00";
    };
    allowReboot = true;
    randomizedDelaySec = "15min";
  };
}
