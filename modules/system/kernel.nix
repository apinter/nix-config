{ config, pkgs, callPackage, ... }:

{
  system.boot.loader.kernelFile = "vmlinuz";
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
