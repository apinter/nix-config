{ pkgs-unstable, lib-usntable, ... }:

{
  nixpkgs.config.packageOverrides = pkgs-unstable: {
    vaapiIntel = pkgs-unstable.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs-unstable; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
