{ config, pkgs, callPackage, ... }:

{
  users.users.bryxina = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "video" "scanner" "lp" ];
  };

}