{ config, pkgs, callPackage, ... }:

{
  users.users.nathan = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "video" "scanner" "lp" ];
  };

}