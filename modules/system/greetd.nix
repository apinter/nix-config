{ config, pkgs, callPackage, ... }:

{
  services.greetd = {
    enable = true;                                                         
    settings = {                                                           
      default_session = {                                                  
        # command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";                                                  
      };                                                                   
    };                                                                     
  };
}
