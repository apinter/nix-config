{ config, pkgs, callPackage, ... }:

{
  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };
    fstrim = {
      enable = true;
    };
  };
}
