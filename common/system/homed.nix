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

  environment.etc."subuid".text = ''
    apinter:100000:65536
    adathor:200000:65536
  '';

  environment.etc."subgid".text = ''
    apinter:100000:65536
    adathor:200000:65536
  '';
}
