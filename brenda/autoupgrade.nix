{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    persistent = true;
    flake = "github:apinter/nix-config";
    flags = [ 
      "--no-write-lock-file"
      "--update-input" "nixpkgs"
      "-L"
      ];
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
    allowReboot = true;
    randomizedDelaySec = "15min";
  };
}