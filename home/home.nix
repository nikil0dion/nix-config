{ config, pkgs, ...}: {

  imports = [ ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "24.11";
      packages = with pkgs; [
         audacity
         bluez
         bottles-unwrapped
         cachix
         cursor
         dconf
         dconf-editor
         docker
         docker-compose
         drawio
         ffmpeg-full
         file
         floorp
         gcc-wrapper
         gimp
         gnome-tweaks
         gnumake
         gst-plugins-base
         gst-plugins-good
         gstreamer
         kdenlive
         keepassxc
         kubectl
         lsd
         lsof
         meld
         minikube
         nekoray
         neofetch-unstable
         obsidian
         pgadmin
         python3.12-pip
         steam
         telegram-desktop
         tokyonight-gtk-theme-0-unstable
         vlc
         vulkan-tools
         warp-terminal
      ];
  };
}
