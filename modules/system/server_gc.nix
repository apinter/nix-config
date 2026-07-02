{ config, lib, pkgs, ... }:

{
  nix = { 
    gc = {
      automatic = true;
      persistent = true;
      dates = "daily";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "30m";
    };
  };
}

