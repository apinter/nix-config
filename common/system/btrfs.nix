{ config, pkgs, callPackage, ... }:

{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
  services.fstrim.enable = true;
}