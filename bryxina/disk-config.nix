{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/etc" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/etc";
                  };
                  "/opt" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/opt";
                  };
                  "/var" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/var";
                  };
                  "/root" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/root";
                  };
                  "/tmp" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/tmp";
                  };
                };
                mountpoint = "/partition-root";
              };
            };
          };
        };
      };
    };
  };
}