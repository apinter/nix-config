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

  system.activationScripts.subuidsubgidredo.text = ''
    usermod --add-subuids 524288-589823 --add-subgids 524288-589823 adathor
  '';
}
