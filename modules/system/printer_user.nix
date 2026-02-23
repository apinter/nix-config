{ pkgs, ...  }:

{
  services = {
    printing = {
      enable = true;
      cups-pdf.enable = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
