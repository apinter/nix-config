{ config, pkgs, callPackage, ... }:

{
    services.cockpit = {
        enable = true;
        port = 9090;
        settings = {
            WebService = {
                AllowUnencrypted = true;
            };
        };
    };
}