{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    audacity
    firefox
    firefox-esr
    telegram-desktop
    obs-studio
    rofi
    wofi
    mpv
    kdenlive
    gparted
    obsidian
    zoom-us
    pcmanfm-qt
    handbrake

    # Coding stuff
    go
    vscodium

    # CLI utils
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
    yt-dlp
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

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    greetd.tuigreet
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
    hyprpaper

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU stuff 
    amdvlk
    glaxnimate

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy

    # Other
    home-manager
    spice-vdagent
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-nord
    xray
  ];

}
