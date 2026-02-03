{ config, pkgs, callPackage, ... }:

{

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pkgs.pavucontrol
  ];
}
