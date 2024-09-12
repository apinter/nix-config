{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "12.15";
    persistent = true;
    flake = "github:apinter/nix-config/unstable";
    flags = [ 
      "--no-write-lock-file"
      "-L"
      ];
    allowReboot = true;
    randomizedDelaySec = "15min";
    rebootWindow = {
      lower = "11:00";
      upper = "13:00";
    };
  };
}
