{ config, pkgs, callPackage, meta, ... }:

{
  services.sanoid.enable = true;
  services.sanoid.templates.shirayuki = {
    autosnap = true;
    autoprune = true;
    daily = 7;
    monthly = 1;
    hourly = 0;
  };

  services.sanoid.datasets = {  
    "shirayuki/Home" = {
      useTemplate = [ "shirayuki" ];
      recursive = true;
    };
    "shirayuki/Backup" = {
      useTemplate = [ "shirayuki" ];
      recursive = true;
    };
    "shirayuki/Borg" = {
      useTemplate = [ "shirayuki" ];
      recursive = true;
    };
    "shirayuki/Crate-data" = {
      useTemplate = [ "shirayuki" ];
      recursive = true;
    };
    "shirayuki/immich" = {
      useTemplate = [ "shirayuki" ];
      recursive = true;
    };
  };
}
