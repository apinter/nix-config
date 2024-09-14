{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.graphics= {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.mesa.drivers ];
    # extraPackages = with pkgs; [
    #   intel-media-driver
    #   vaapiIntel
    #   vaapiVdpau
    #   libvdpau-va-gl
    #   mesa.drivers
    # ];
  };
}
