![](homelab_topo.svg)

## Usage

```
nix run github:nix-community/nixos-anywhere \
--extra-experimental-features "nix-command flakes" \
-- --flake 'github:apinter/nix-config#k8s00' nixos@172.168.255.22


nixos-rebuild \
  --flake .#mySystem \
  --target-host deployuser@deployhost \
  --use-remote-sudo \
  switch
```