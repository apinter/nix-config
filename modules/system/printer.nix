{ pkgs, ...  }:

{

  nixpkgs.config.allowUnfree = true;
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.sane-backends pkgs.gutenprint pkgs.brlaser ];
      browsing = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      defaultShared = true;
      cups-pdf.enable = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    udev = {
      packages = [ pkgs.sane-airscan ];
    };
    # ipp-usb = {
    #   enable=true;
    # };
  };
  hardware = {
    sane = {
      enable = true;
      brscan4 = {
        enable = true;
      };
      extraBackends = [ pkgs.sane-airscan ];
    };
  };
}
