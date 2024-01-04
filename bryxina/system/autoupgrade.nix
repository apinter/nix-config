{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    persistent = true;
    flake = "/home/apinter/nix-config";
    flags = [ 
      "--recreate-lock-file"
      "-L"
      ];
    allowReboot = false;
    randomizedDelaySec = "15min";
  };
}