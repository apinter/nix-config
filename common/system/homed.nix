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

  users.users.adathor.subUidRanges = [
  {
    count = 165534;
    startUid = 100001;
    };
  ];
  users.users.adathor.subGidRanges = [
  {
    count = 165534;
    startGid = 100001;
    };
  ];
}
