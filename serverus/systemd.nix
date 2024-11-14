{ config, pkgs, lib, ... }:

{
systemd.services.nebula = {
    enable = false;
    description = "Nebula VPN";
    after = [ "network-online.target" "basic.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
        SyslogIdentifier = "nebula";
        ExecStart = "/data/nebula/nebula -config /data/nebula/config.yml";
        Restart = "always";
        RestartSec = "5";
        };
    };
}
