{ config, pkgs, lib, ... }:

{

virtualisation.oci-containers.containers."minecraft-foe" = {
  autoStart = true;
  image = "docker.io/itzg/minecraft-server:latest";
  ports = [ "25565:25565" ];
  volumes = [
    "/home/apinter/Minecraft_foreever_world/minecraft5/_data:/data"
  ];
  environment = {
    OPS = "adathor";
    EULA = "TRUE";
    MEMORY = "8G";
    USE_AIKAR_FLAGS = "true";
    SIMULATION_DISTANCE = "32";
    VIEW_DISTANCE = "32";
    DIFFICULTY = "normal";
    ICON = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstaticg.sportskeeda.com%2Feditor%2F2022%2F12%2F31a05-16709054062680-1920.jpg";
    };
  };

}
