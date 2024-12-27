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
 users.user.nixos = { 
    isNormalUser = true; 
    description = "nix";
    extraGroups = [ "networkmanager" ];
};fp

 # Enable nix Flakes
 nix.settings.experimental-features = [ "nix-command" "flakes" ]

 # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];
}

   # Realtime Policy and Watchdog Daemon
   security.rtkit.enable = true;

   # Polkit enable
   security.polkit.enable = true;

   # Hyperlock screen 
   security.pam.services.hyprlock = { };

  #services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the general xdg-desktop-portal service
  services.xdg-desktop-portal.enable = true;

  # Enable xdg-desktop-portal-hyprland for Hyprland compatibility
  services.xdg-desktop-portal-hyprland.enable = true;

  # If you are using Hyprland as your compositor, make sure it's enabled:
  services.xserver.windowManager.hyprland.enable = true;
  
  # OpenGL
  hardware.opengl = {
    enable = true;  # Enable OpenGL
    driSupport = true;  # Enable DRI (Direct Rendering Infrastructure)
    driSupport32Bit = true;  # Enable 32-bit DRI support for compatibility
  };

# Vulkan support
  hardware.vulkan = {
    enable = true;
    drivers = [ "amdvlk" ];  # Use AMD's Vulkan driver
  };

# System version 
 system.stateVersion = "24.11";
}
