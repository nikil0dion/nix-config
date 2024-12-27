{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    firefox
    firefox-esr
    telegram-desktop
    brave
    rofi
    wofi
    vlc
    gparted
    obsidian
    handbrake

    # Coding stuff
    go
    vscodium

    # CLI utils
    lsd
    neofetch
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
    scrot
    ffmpeg
    light
    lux
    mediainfo
    ranger
    zram-generator
    cava
    zip
    brightnessctl
    swww
    openssl
    lazygit
    bluez
    bluez-tools
    docker
    kubectl

    # GUI utils
    feh
    imv
    dmenu
    screenkey
    mako
    gromit-mpx
    httpie

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    herbstluftwm
    hyprland
    seatd
    xdg-desktop-portal-hyprland
    polybar
    waybar
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle

    # Sound
    pipewire

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy

    # Other
    home-manager
    spice-vdagent
    tokyo-night-gtk
    xray
    nekoray
  ];

}
