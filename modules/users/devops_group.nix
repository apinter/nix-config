{ config, pkgs, callPackage, ... }:

{
  security.sudo.extraRules = [
    {
      groups = [ "devops" ];
      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];
 
  users.groups.devops.gid = 5000;
}
