{ config, pkgs, lib, ... }:

{

virtualisation.oci-containers.containers."minecraft" = {
  autoStart = true;
  image = "docker.io/itzg/minecraft-server:latest";
  ports = [ "25565:25565" ];
  volumes = [
    "minecraft:/data"
  ];
  environment = {
    OPS = "adathor";
    ##JVM_XX_OPTS = "-XX:MaxRAMPercentage=65";
    EULA = "TRUE";
    MEMORY = "8G";
    USE_AIKAR_FLAGS = "true";
    ENABLE_COMMAND_BLOCK = "true" ;
    };
  };

}
