{ config, pkgs-unstable, lib-usntable, ... }:

{
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9100;
      };
    };
  };
}
