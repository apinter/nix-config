{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=rootfs" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EC3A-1C5A";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/etc" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=etc" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/opt" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=opt" ];
    };

  fileSystems."/partition-root" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
    };

  fileSystems."/root" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/steam" =
    { device = "/dev/disk/by-uuid/08443b6a-c83e-4c3b-ae16-57aa3da55e4d";
      fsType = "btrfs";
      options = [ "subvol=steam" ];
    };

  fileSystems."/tmp" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=tmp" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/d5cdc820-248a-4e2f-9e3d-b56a89b2832a";
      fsType = "btrfs";
      options = [ "subvol=var" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
