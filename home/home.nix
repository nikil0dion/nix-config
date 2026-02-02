{ config, pkgs, ...}: {

  imports = [ ];

  home = {
     # username = "nikilodion";
     # homeDirectory = "/home/nikilodion";
      stateVersion = "25.11";

      sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        # Wayland touchscreen support
        GDK_BACKEND = "wayland";           # GTK use wayland
        QT_QPA_PLATFORM = "wayland";       # Qt use wayland
        CLUTTER_BACKEND = "wayland";       # Clutter use wayland
        SDL_VIDEODRIVER = "wayland";       # SDL use wayland
      };

      packages = with pkgs; [
        alsa-utils
        amber-lang
        android-tools
        appimage-run
        audacity
        bind
        bluez
        bottles
        caligula
	claude-code
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
	eza
        fd
        ffmpeg-full
        figma-linux
        file
        file-roller
        floorp-bin
        gedit
	gimp-with-plugins
        gnome-calculator
        gnome-characters
        gnome-disk-utility
        gnome-keyring
        gnome-terminal
        gnome-tweaks
        gnome-weather
        gnumake
        google-chrome
        grpcurl
        gtk4
	gtk3
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
        sops
        subfinder
        sysstat
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
