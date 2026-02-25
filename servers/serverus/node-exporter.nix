{ config, pkgs, lib, ... }:

{
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        listenAddress = "17.10.0.1";
        port = 9100;
      };
    };
  };
}

