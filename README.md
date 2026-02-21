# NixOS Fleet Configuration

A comprehensive NixOS flake-based configuration for managing a homelab fleet of servers and workstations.

![Homelab Topology](homelab_topo.svg)

## Overview

This repository manages multiple NixOS systems using a centralized flake configuration with shared modules, enabling consistent and reproducible deployments across diverse hardware. The configuration leverages modern NixOS features including flakes, home-manager, disko for disk management, and nixos-hardware for optimal hardware support.

## Systems

### Workstations
- **bryxina** - Intel-based workstation with Hyprland, hardware acceleration, and Gitea runner
- **otong** - AMD-based workstation with SSD optimizations
- **sofie** - Intel-based workstation with home-manager integration
- **levander** - AMD-based system with disko and home-manager
- **throtur** - Intel-based workstation with home-manager
- **umbra** - System with home-manager integration

### Servers
- **media** - Media server with Sway, hardware acceleration, Podman, and Tailscale
- **busybee** - Intel-based server with VS Code server support
- **serverus** - Intel-based server with disko for automated disk partitioning

### Kubernetes Cluster
- **k8s00, k8s01, k8s02** - Three-node Kubernetes cluster with Intel hardware, disko, and QEMU guest optimizations

## Repository Structure

```
.
├── flake.nix           # Main flake configuration
├── home.nix            # Home-manager user configuration
├── common/             # Shared modules
│   ├── DE/            # Desktop environments (Hyprland, Sway, Plasma6, GNOME, XFCE)
│   ├── hardware/      # Hardware configurations (bluetooth, acceleration, fwupd)
│   ├── networking/    # Network configs (SSH, Tailscale, WireGuard, firewall)
│   ├── monitoring/    # Monitoring tools (node-exporter)
│   ├── system/        # System configurations (Docker, Podman, autoupgrade, etc.)
│   ├── systemd-user/  # User systemd services
│   └── users/         # User account definitions
├── <hostname>/        # Per-host configurations
│   ├── configuration.nix
│   ├── hardware-configuration.nix
│   └── ...           # Host-specific modules
└── k8s/              # Kubernetes nodes configuration
```

## Features

### Desktop Environments
- **Hyprland** - Wayland compositor with modern features
- **Sway** - i3-compatible Wayland compositor
- **Plasma6** - KDE Plasma 6 desktop
- **GNOME** - GNOME desktop environment
- **XFCE** - Lightweight desktop environment

### System Features
- Automated system upgrades and garbage collection
- Hardware acceleration support
- Bluetooth configuration
- Firmware updates via fwupd
- Container support (Docker/Podman)
- Tailscale mesh networking
- WireGuard VPN
- SSH hardening
- Monitoring with node-exporter
- Gitea Actions runner support
- VS Code server integration

### Disk Management
Systems using **disko** for declarative disk partitioning:
- media
- levander
- serverus
- k8s00, k8s01, k8s02

## Usage
### Local Installation

Download, flash, and boot from the [NixOS](https://nixos.org/download/) installation media.

Ideally there is a `disk-configuration.nix` file for the target system that can be used with `disko`. If there is isn't you need to configure the disk manually, otherwise:

```bash
sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /path/to/my/disko-config.nix
```

Followed by:

```bash
cd /mnt
sudo nixos-install --flake github:apinter/nix-config#hostname
```

### Remote Installation with nixos-anywhere

Deploy a system remotely using nixos-anywhere:

```bash
nix run github:nix-community/nixos-anywhere \
  --extra-experimental-features "nix-command flakes" \
  -- --flake 'github:apinter/nix-config#k8s00' nixos@172.168.255.22
```

### Local System Rebuild

```bash
# Local rebuild
sudo nixos-rebuild switch --flake .#hostname

# Remote rebuild
nixos-rebuild switch \
  --flake .#hostname \
  --target-host user@hostname \
  --use-remote-sudo
```

### Building Specific Configurations

```bash
# Build without switching
nix build .#nixosConfigurations.hostname.config.system.build.toplevel

# Test configuration
sudo nixos-rebuild test --flake .#hostname

# Build and activate on boot (safe testing)
sudo nixos-rebuild boot --flake .#hostname
```

### Home Manager

For systems with home-manager integration (sofie, levander, throtur, umbra):

```bash
# Rebuild includes home-manager changes
sudo nixos-rebuild switch --flake .#hostname
```

## Dependencies

The flake uses the following inputs:
- **nixpkgs** - NixOS unstable channel
- **home-manager** - User environment management
- **nixos-hardware** - Hardware-specific optimizations
- **vscode-server** - VS Code remote server support
- **disko** - Declarative disk partitioning

## Customization

### Adding a New Host

1. Create a directory: `mkdir newhostname`
2. Add `configuration.nix` and `hardware-configuration.nix`
3. Update `flake.nix` to include the new host:

```nix
newhostname = lib.nixosSystem {
  inherit system;
  modules = [
    ./newhostname/configuration.nix
    # Add common modules as needed
  ];
};
```

### Using Common Modules

Import shared modules in your host's `configuration.nix`:

```nix
imports = [
  ../modules/DE/hyprland.nix
  ../modules/networking/tailscale.nix
  ../modules/system/autoupgrade.nix
  ../modules/system/garbagecollect.nix
];
```

## Security

- SSH configurations with hardening
- Firewall rules via common modules
- Tailscale for secure mesh networking
- Cosign public key included for package verification

## License

See [LICENSE](LICENSE) file for details.
