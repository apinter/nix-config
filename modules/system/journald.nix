{ config, lib, pkgs, ... }:

{
  services.journald.extraConfig = ''
    [Journal]
    Storage=auto
    SystemMaxUse=1G
    RuntimeMaxUse=1G
   '';
}
