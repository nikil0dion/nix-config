{ config, pkgs, ...}: {

  imports = [ ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "24.11";
      packages = with pkgs; [
         gimp
         bluez
         cachix
         cursor
         dconf
         dconf-editor
         docker
         docker-compose
         floorp
         gcc-wrapper
         gnome-tweaks
         gnumake
         kdenlive
         keepassxc
         kubectl
         lsd
         meld
         minikube
         nekoray
         neofetch
         obsidian
         pgadmin
         steam
         telegram-desktop
         tokyonight-gtk-theme-0-unstable
         vulkan-tools
         warp-terminal
      ];
  };
}
