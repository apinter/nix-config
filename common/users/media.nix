{ config, pkgs, callPackage, ... }:

{
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.sway}/bin/sway";
  #       user = "mediacenter";
  #     };
  #   };
  # };

  users.users.mediacenter = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "video" "audio" ];
  };
}
