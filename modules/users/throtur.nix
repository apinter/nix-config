{ config, pkgs, callPackage, ... }:

{
  users.users.throtur = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "video" "scanner" "lp" ];
  };

}