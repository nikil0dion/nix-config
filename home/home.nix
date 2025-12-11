{ config, pkgs, ...}: {

  imports = [ ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "25.05";
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
        floorp
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
        google-fonts-unstable
        grpcurl
        gst-plugins-base
        gst-plugins-good
        gstreamer
        gtk+3
        hamster
        htop
        httpie-desktop
        iptables
        jq
        kdenlive
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
        neofetch-unstable
        ninja
        nmap
        noto-fonts-color-emoji
        nss-cacert
        obsidian
        pciutils
        postgresql
        qemu-host-cpu-only
        quickemu
        remmina
        sdkmanager
        snx-rs
        sops
        sysstat
        telegram-desktop
        totem
        tradingview
        tree
        trivy
        unetbootin
        unzip
        valkey
        xdotool
        zip
        zoom
      ];
  };
}
