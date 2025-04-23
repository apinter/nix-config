{ config, pkgs, callPackage, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
