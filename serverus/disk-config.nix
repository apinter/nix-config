{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            MBR = {
            type = "EF02";
            size = "1M";
            priority = 1;
            };
             root = {
               size = "100%";
               content = {
                 type = "btrfs";
                 extraArgs = [ "-f" ];
                 mountpoint = "/";
                 mountOptions = [ "compress=zstd" "noatime" ];
               };
             };
            boot = {
              size = "500M";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
          };
        };
      };
    };
  };
}
