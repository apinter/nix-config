{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.222.0.15/24" ];
      listenPort = 51820;

      privateKey = "";
      dns = [ "10.222.0.1" ];

      peers = [
        {
          publicKey = "";
          allowedIPs = [ "0.0.0.0/0" "::/0"];
          endpoint = ""; 
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
