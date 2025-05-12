{ config, pkgs, callPackage, ... }:

{
  services.dbus.enable = true;

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  
  xdg.mime.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    wrapperFeatures.base = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    alacritty
    pulseaudio
    pavucontrol
    wayland
    waybar
    wofi
    xdg-utils
    glib
    dracula-theme
    adwaita-icon-theme
    swaylock
    swayidle
    grim
    slurp
    wl-clipboard
    bemenu
    mako
    wdisplays
    vim
    wget
    tmux
    curl
    just
    ranger
    screen
    git
    python3
    distrobox
    xorg.xhost
    gnome-keyring
    conmon
    crun
    slirp4netns
    su
    distrobox
    skopeo
    buildah
    gnupg
    yubikey-personalization
    wireguard-tools
    cryfs
    nautilus
    playerctl
    brightnessctl
    pamixer
    ## Archcraft
    swaybg
    kanshi
    foot
    wf-recorder
    light
    yad
    zathura
    glow
    wlogout
    mpv
    mdp
    mpc
    viewnior
    imagemagick
    playerctl
    pastel
    pywal
    rofi-wayland
    pulsemixer
    xdg-user-dirs
    xdg-desktop-portal
  ];

  fonts = {
    packages =  with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  programs.light.enable = true;
  programs.sway.extraSessionCommands = ''
    export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
    export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
    eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh);
    export SSH_AUTH_SOCK;
  '';
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
}
