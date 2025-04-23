{ config, pkgs, callPackage, ... }:

{
  users.users.sofie = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "video" "scanner" "lp" ];
  };

}