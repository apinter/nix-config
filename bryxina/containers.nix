{ config, pkgs, lib, ... }:

{

virtualisation.oci-containers.containers."minecraft" = {
  autoStart = true;
  image = "docker.io/itzg/minecraft-server:latest";
  ports = [ "25565:25565" ];
  volumes = [
    "minecraft4:/data"
  ];
  environment = {
    OPS = "adathor";
    EULA = "TRUE";
    MEMORY = "8G";
    USE_AIKAR_FLAGS = "true";
    ENABLE_COMMAND_BLOCK = "true" ;
    SEED = "-7569437332291102067";
    };
  };

virtualisation.oci-containers.containers."minecraft4" = {
  autoStart = false;
  image = "docker.io/itzg/minecraft-server:latest";
  ports = [ "25570:25565" ];
  volumes = [
    "minecraft4:/data"
  ];
  environment = {
    OPS = "adathor,bryxina";
    EULA = "TRUE";
    MEMORY = "8G";
    USE_AIKAR_FLAGS = "true";
    SEED = "-1378589454";
    };
  };
}
