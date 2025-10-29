{ pkgs, ...  }:

{

nixpkgs.config.allowUnfree = true;
services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
};

}
