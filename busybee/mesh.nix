{ config, pkgs, lib, ... }:

{
services.nebula.networks.mesh = {
    enable = true;
    isLighthouse = false;
    cert = "/data/nebula/crate.crt";
    key = "/data/nebula/crate.key";
    ca = "/data/nebula/ca.crt";
    staticHostMap = {
        "17.10.0.1" = ["172.236.137.141:4242"];
        };
    listen.host = "0.0.0.0";
    listen.port = 4242;
    firewall.inbound = [
        {
            port = "any";
            proto = "icmp";
            host = "any";
        }
        {
            port = "any";
            proto = "any";
            groups = ["devops" "server"];
        }
        ];
    firewall.outbound = [
        {
            port = "any";
            proto = "any";
            host = "any";
        }
        ];
    settings = {
        lighthouse = {
            hosts = "17.10.0.1";
        };
        punchy = {
          punch = true;
          cipher = "chachapoly";
          preferred_ranges = ["172.168.0.0/16"];
        };
        relay = {
            am_relay = false;
            use_relays = false;
        };
        tun = {
            disabled = false;
            dev = "nebula1";
            drop_local_broadcast = false;
            drop_multicast = false;
            tx_queue = 500;
            mtu = 1300;
        };
        logging = {
            level = "info";
            format = "text";
        };
        firewall.conntrack = {
            tcp_timeout = "12m";
            udp_timeout = "3m";
            default_timeout = "10m";
        };
    };
  };
}
