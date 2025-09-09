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

  users.extraUsers.adathor.subUidRanges = [
  {
    count = 65534;
    startUid = 200000;
    }
  ];
  users.extraUsers.adathor.subGidRanges = [
  {
    count = 65534;
    startGid = 200000;
    }
  ];
}
