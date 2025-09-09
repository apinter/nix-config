{ config, lib, pkgs, ... }:

{
  services.homed ={
    enable = true;
    settings.Home = {
      DefaultFileSystemType = "btrfs";
      DefaultStorage = "luks";
    };
  };

  services.userdbd = {
    enable = true;
    enableSSHSupport = true;
  };
}
