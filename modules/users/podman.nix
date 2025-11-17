
{ config, pkgs, callPackage, ... }:

{
  users.users.remote-podman = {
    isNormalUser = true;
    initialPassword = "pw123";
    home = "/home/remote-podman";
    description = "Podman";
    extraGroups = [ "podman" "docker"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICmE7nw0uD/Ae2ODC0bDoazXo0rjIyYA4I8EBdY+7peJ"
    ];
    linger = true;
  };

}
