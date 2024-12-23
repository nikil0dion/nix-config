{ hyprland, pkgs, ...}: {

  imports = [
    hyprland.homeManagerModules.default
    #./environment
    ./programs
    ./scripts
    ./themes
  ];

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
  };

  home.packages = (with pkgs; [
    
    #User Apps
    celluloid
    firefox
    firefox-esr
    librewolf
    go
    vscodium
    vulkan-headers
    

    #utils
    ranger
    wlr-randr
    catimg
    curl
    git
    appimage-run
    xflux
    dunst
    pavucontrol
    kubectl
    docker

    #misc 
    cava
    nano
    rofi
    nitch
    wget
    grim
    slurp
    wl-clipboard
    mpc-cli
    tty-clock
    exa
    btop
    tokyo-night-gtk

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
      name = "Tokyonight-Dark-B-LB";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
