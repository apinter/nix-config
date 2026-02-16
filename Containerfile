FROM registry.opensuse.org/opensuse/tumbleweed

RUN zypper ref && zypper dup -y
RUN zypper in -y git curl 
RUN curl -L https://nixos.org/nix/install | sh -s --  --daemon --yes

ENV PATH="export PATH=/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

RUN mkdir -p /flake

WORKDIR /flake
