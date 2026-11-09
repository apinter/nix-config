{ config, ... }:
{
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets."justatest" = {
    sopsFile = ../../secrets/hello.ini.enc;
    format = "binary";
    owner = "bryxina";
    mode = "0400";
  };
  sops.secrets."another" = {
    sopsFile = ../../secrets/test;
    format = "binary";
    owner = "bryxina";
    mode = "0400";
  };
  sops.secrets."who" = {
    sopsFile = ../../secrets/test;
    format = "binary";
    owner = "bryxina";
    mode = "0400";
  };
}
