{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/disk/by-diskseq/9";
        content = {
          type = "gpt";
          partitions = {
            MBR = {
            type = "EF02"; # for grub MBR
            size = "100M";
            priority = 1; # Needs to be first partition
            };
            # root = {
            #   size = "100%";
            #   content = {
            #     type = "btrfs";
            #     extraArgs = [ "-f" ]; # Override existing partition
            #     mountpoint = "/";
            #     mountOptions = [ "compress=zstd" "noatime" ];
            #   };
            # };
            boot = {
              size = "500M";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  # Subvolume name is the same as the mountpoint
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/opt" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/opt";
                  };
                  "/var" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/var";
                  };
                  "/etc" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/etc";
                  };
                };
              };
            };
          };
        };
      };
    };
    # nodev = {
    #   "/tmp" = {
    #     fsType = "tmpfs";
    #     mountOptions = [
    #       "size=200M"
    #     ];
    #   };
    # };
  };
}
