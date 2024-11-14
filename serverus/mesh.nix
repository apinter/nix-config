{ config, pkgs, lib, ... }:

{
services.nebula.networks.mesh = {
    enable = true;
    isLighthouse = true;
    cert = "/data/nebula/lighthouse.crt";
    key = "/data/nebula/lighthouse.key";
    ca = "/data/nebula/ca.crt";
    staticHostMap = {
        "17.10.0.1" = ["194.233.75.126:4242"];
        };
    listen.host = "0.0.0.0";
    listen.port = 4242;
    firewall.inbound = [
        {
            port = "any";
            proto = "icmp";
            host = "any";
        };
        {
            port = "any";
            proto = "any";
            groups = ["devops" "server"];
        };
        ];
    firewall.outbound = [
        {
            port = "any";
            proto = "any";
            host = "any";
        };
        ];
    settings = {
        punchy = {
          punch = true;
          cipher = "aes";
          preferred_ranges = ["172.168.0.0/16"];
        };
        relay = {
            am_relay = false;
            use_relays = false;
        };
        tun = {
            disabled = false;
            dev = nebula1;
            drop_local_broadcast = false;
            drop_multicast = false;
            tx_queue = 500;
            mtu = 1300;
        };
        logging = {
            level = info;
            format = text;
        };
        firewall.conntrack = {
            tcp_timeout = 12m;
            udp_timeout = 3m;
            default_timeout = 10m;
        };
    };
  };
}