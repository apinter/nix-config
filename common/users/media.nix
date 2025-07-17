{ config, pkgs, callPackage, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user mediacenter --time --cmd sway";
        user = "mediacenter";
      };
    };
  };

  users.users.mediacenter = {
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "video" "audio" ];
  };
}
