{ config, ... }:
{
  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    useSystemdActivation = true;
  };

  sops.secrets."justatest.yaml" = {
    sopsFile = ../../secrets/hello.ini.enc;
    format = "binary";
    owner = "bryxina";
    mode = "0400";
  };
  sops.secrets."another.json" = {
    sopsFile = ../../secrets/test;
    format = "binary";
    owner = "bryxina";
    mode = "0400";
  };
  sops.secrets."who.txt" = {
    sopsFile = ../../secrets/test;
    format = "binary";
    owner = "bryxina";
    mode = "0400";
  };
}
