FROM registry.opensuse.org/opensuse/tumbleweed

RUN zypper ref && zypper dup -y
RUN zypper in -y git curl
RUN curl -L https://nixos.org/nix/install | sh -s --  --daemon --yes

RUN mkdir -p /flake

WORKDIR /flake

ENTRYPOINT ["/bin/bash"]