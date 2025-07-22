{ config, pkgs, ...}: {

  imports = [ ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "25.05";
      packages = with pkgs; [
         alsa-utils
	       audacity
	       appimage-run
         bluez
         bottles-unwrapped
         cachix
	       clickhouse
         cursor
         dconf
         dive
         dbeaver-bin
         dconf-editor
         docker
         docker-compose
         drawio
         ffmpeg-full
         figma-linux
         file
         floorp
         gcc-wrapper
         gimp
         gnome-tweaks
         gnumake
         grpcurl
         gst-plugins-base
         gst-plugins-good
         gstreamer
         hamster
         httpie-desktop
         kdenlive
         keepassxc
         kubectl
         lsd
         lsof
         lynis
         meld
         minikube
         minio-client-
         nekoray
         neofetch-unstable
         obsidian
         pgadmin
         postgresql
         pciutils
         python3.12-pip
         steam
         sdkmanager
         telegram-desktop
         tokyonight-gtk-theme-0-unstable
         vlc
         vulkan-tools
         warp-terminal
	       wget
         zip
      ];
  };
}
