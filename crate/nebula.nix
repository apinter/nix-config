{ config, lib, pkgs, ... }:

{

    services.nebula.networks.mesh = {
        enable = true;
        isLighthouse = false;
        cert = "/root/.secrets/ca.crt";
        key = "/root/.secrets/nebula/crate.key";
        ca = "/root/.secrets/nebula/crate.crt";
        staticHostMap = {
            "17.10.0.1" = [ "45.118.132.161:4242" ];
        };
        lighthouses = [ "17.10.0.1" ];
        settings = {
            punchy = {
                punch = "true";
            };
            lighthouse = {
                hosts = "17.10.0.1";
            };
            listen = {
                host = "0.0.0.0";
                port = "4242";
            };
            cipher = "aes";
            preferred_ranges = ["172.168.0.0/16"];
        };
        firewall.outbound = [
        {
            host = "any";
            port = "any";
            proto = "any";
        };
        ];
        firewall.inbound = [
        {
            host = "any";
            port = "any";
            proto = "icmp";
        };
        {
            groups = [ "devops" "server" ];
            port = "any";
            proto = "any";
        };
        ];
    };
}
