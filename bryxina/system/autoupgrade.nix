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
    allowReboot = false;
    randomizedDelaySec = "15min";
  };
}