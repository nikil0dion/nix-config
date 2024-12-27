{ config, pkgs, ...}:

{ 
  imports = [
      ./hardware-configuration.nix
      ./linux-kernel.nix
      ./services.nix
    ];

 # Your hostname
 networking.hostName = "nix";

 # Enable networking 
 networking.networkmanager.enable = true;

 # Network Time server 
 networking.timeServers = [ "pool.ntp.org" ];

 # Set time zonenanop
 time.timeZone = "UTC";

 # Select internationalisation propertis
 i18n.defaultLocale = "en_US.UTF-8";

# Define a user accout 
 users.users.nixos = { 
    isNormalUser = true; 
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" ];
};

 # Enable nix Flakes
 nix.settings.experimental-features = [ "nix-command" "flakes" ];
 # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];

   # Realtime Policy and Watchdog Daemon
   security.rtkit.enable = true;

   # Polkit enable
   security.polkit.enable = true;

   # Hyperlock screen 
   security.pam.services.hyprlock = { };

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the general xdg-desktop-portal service
  xdg.autostart.enable = true;

# System version 
 system.stateVersion = "24.11";
}
