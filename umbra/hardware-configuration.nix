{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/hardware/network/broadcom-43xx.nix")
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3cf850cb-9c22-412d-b8b5-654b07600284";
      fsType = "btrfs";
      options = [ "subvol=ROOT" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E334-509A";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/8ba08344-4bcd-4750-aee5-721f85746e18";
  boot.initrd.luks.devices."root".allowDiscards = true;

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

