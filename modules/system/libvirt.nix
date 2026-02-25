{ config, pkgs, callPackage, meta, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  users = {
    groups = { 
      libvirtd = {
        members = [ meta.username ];
      };
      kvm = {
        members = [ meta.username ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-boxes
    dnsmasq
    phodav
  ];
}
