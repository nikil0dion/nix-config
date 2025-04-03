{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./linux-kernel.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Hostname
  networking.hostName = "nixos"; # Define your hostname.

  # Network
  networking.networkmanager.enable = true;  

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Virtualization Docker and Vmbox
  virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "nikilodion" ];
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  #users.extraGroups.docker.members = [ "nikilodion" ];
  virtualisation.docker.rootless = {
  	enable = true;
  	setSocketVariable = true;
  };

  # Gaaame
  programs.steam = {
  	enable = true;
  	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  	dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  	localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 and wayland windowing system.
  services.xserver.enable = true;

  # Enable Gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # Fonts 
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable sound jack 
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     jack.enable = true;
     pulse.enable = true;
   };


  # Minimal packages 
   environment.systemPackages = with pkgs; [
     wget
     git
     curl
     htop
  ];

  # Security mod
  security.rtkit.enable = true;
  security.polkit.enable = true;

  # Version
  system.stateVersion = "24.11";

}
