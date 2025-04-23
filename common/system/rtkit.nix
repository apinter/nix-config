{ config, pkgs, callPackage, ... }:

{
  security.rtkit.enable = true;
}