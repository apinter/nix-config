{ config, pkgs, callPackage, ... }:

{
  services = {
    dbus = {
      enable = true;
    };
    gnome-keyring = {
      enable = true;
    };
  };

  security = {
    pam ={
      services = {
        hyprlock.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
      };
    };
  };

  xdg = {
    mime.enable = true; 
    autostart.enable = true;
    portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
      };
    };
  };

  programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
      light = {
        enable = true;
      };
  };

  environment.systemPackages = with pkgs; [
    cliphist
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
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    gnome-keyring
    conmon
    crun
    slirp4netns
    su
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
    xorg.xrandr
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
    rofi
    pulsemixer
    xdg-user-dirs
    hyprpaper
  ];

  fonts = {
    packages =  with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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


  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
};
}
