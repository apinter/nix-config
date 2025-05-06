{ pkgs, ...  }:

{

nixpkgs.config.allowUnfree = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.printing.drivers = [ pkgs.sane-backends pkgs.gutenprint pkgs.brlaser ];
  services.avahi.openFirewall = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  services.printing.browsing = true;
  services.printing.listenAddresses = [ "*:631" ];
  services.printing.allowFrom = [ "all" ];
  services.printing.defaultShared = true;
  services.printing.cups-pdf.enable = true;
  hardware = {
    sane = {
      enable = true;
      brscan4 = {
        enable = true;
      };
      extraBackends = [ pkgs.sane-airscan ];
    };
  };
  services.udev.packages = [ pkgs.sane-airscan ];
  services.ipp-usb.enable=true;
}
