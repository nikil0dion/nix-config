{ hyprland, pkgs, ...}: {

  imports = [
    hyprland.homeManagerModules.default
    ./programs
    ./scripts
    ./themes
  ];

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
  };

  home.packages = (with pkgs; [
    
    # Desktop apps
    firefox
    firefox-esr
    telegram-desktop
    rofi
    wofi
    vlc
    kdenlive
    gparted
    obsidian
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

  ]) ++ (with pkgs.gnome; [ 
    nautilus
    zenity
    gnome-tweaks
    eog
    gedit
  ]);

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-Storm-BL-MB";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
