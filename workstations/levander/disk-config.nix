{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "nixos-crypt";
                passwordFile = "/tmp/pass";
                settings = {
                  allowDiscards = true;
                };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
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
};
}

