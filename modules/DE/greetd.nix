{ config, pkgs, callPackage, meta, ... }:

{
  services.greetd = {
    enable = true;                                                         
    settings = {                                                           
      default_session = {                                                  
        # command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${meta.greeterDE}";
        user = "greeter";                                                  
      };                                                                   
    };                                                                     
  };
}
