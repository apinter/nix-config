{ config, pkgs, lib, ... }:

{ 
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens18";
  networking.nat.internalInterfaces = [ "wg0" ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.222.0.1/24" ];

      listenPort = 51820;
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.222.0.0/24 -o ens18 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.222.0.0/24 -o ens18 -j MASQUERADE
      '';
      privateKeyFile = "/data/wireguard/pv_key";

      peers = [
        {
            ## Kazeshini
            publicKey = "A9tNaWa17m3BeQlfKLnXbPx/tu/0VDTub/A+YgellBs=";
            allowedIPs = [ "10.222.0.2/32" ];
        }
        {
            ## ADATHOR HP
            publicKey = "pTGa2kfqa+uGhqg98iLVbHby7Znx7vQyJ+D5Ji9XLhQ=";
            allowedIPs = [ "10.222.0.3/32" ];
        }
        {
            ## SOFIE HP
            publicKey = "qhy3teyfKOzogIBsuQj+A9o1jizhrq3pUScljZV6fQE=";
            allowedIPs = [ "10.222.0.4/32" ];
        }
        {
            ## MAC-XUND
            publicKey = "HkpL1M3q17P9oZVm6qeiTUXjy1XSwZsfFWfgQBHqmBo=";
            allowedIPs = [ "10.222.0.35/32" ];
        }
      ];
     };
   };
}
