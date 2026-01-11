{ config, pkgs, ...}: {

  imports = [ ];

  home = {
   #   username = "nikilodion";
   #   homeDirectory = "/home/nikilodion";
      stateVersion = "25.11";
      packages = with pkgs; [
        alsa-utils
        amber-lang
        android-tools
        appimage-run
        audacity
        bind
        bluez
        bottles-unwrapped
        caligula
        ctop
        cacert
        d-spy
        dbeaver-bin
        dconf
        dconf-editor
        desktop-file-utils
        dive
        docker
        docker-compose
        drawio
        duf
        eog
        fd
        ffmpeg-full
        figma-linux
        file
        file-roller
        floorp-bin
        gedit
        gimp
        gnome-calculator
        gnome-characters
        gnome-disk-utility
        gnome-keyring
        gnome-terminal
        gnome-tweaks
        gnome-weather
        gnumake
        grype
        google-chrome
        google-fonts-unstable
        grpcurl
        gtk3
        gtk4
        hamster
        htop
        httpie-desktop
        iptables
        jq
        kdePackages.kdenlive
        keepassxc
        kubernetes
        ledger-live-desktop
        lsof
        lynis
        meld
        minikube
        minio-client
        nautilus
        nchat
        ninja
        nmap
        noto-fonts-color-emoji
        obsidian
        pciutils
        postgresql
        quickemu
        remmina
        sdkmanager
        snx-rs
        sops
        sysstat
        subfinder
        telegram-desktop
        totem
        tradingview
        tree
        trivy
        unetbootin
        unzip
        valkey
        vlc
        vulkan-tools
        warp-terminal
        wget
        zip
        zoom
      ];
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
