{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "12:15";
    persistent = true;
    flake = "github:apinter/nix-config/unstable";
    flags = [ 
      "--no-write-lock-file"
      "-L"
      ];
    allowReboot = false;
    randomizedDelaySec = "15min";
  };
}
