{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    persistent = true;
    flake = "github:apinter/nix-config/unstable";
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