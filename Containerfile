FROM registry.opensuse.org/opensuse/tumbleweed

RUN zypper ref && zypper dup -y
RUN zypper in -y git curl nix 
# RUN curl -L https://nixos.org/nix/install | sh -s --  --daemon --yes

ENV PATH="/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
ENV NIX_SSL_CERT_FILE=/etc/ssl/ca-bundle.pem

RUN mkdir -p /flake

WORKDIR /flake
