{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.journald.settings.Journal = ''
    [Journal]
    Storage=auto
    SystemMaxUse=1G
    RuntimeMaxUse=1G
  '';
}
